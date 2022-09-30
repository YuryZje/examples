package name.zje.apachefop.cli;

import lombok.extern.slf4j.Slf4j;
import name.zje.apachefop.generator.FopPdfGenerator;
import name.zje.apachefop.generator.PdfGenerator;
import org.apache.commons.cli.*;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.FileOutputStream;
import java.io.StringReader;
import java.util.HashMap;
import java.util.Map;

/**
 * Main application class
 */
@Slf4j
public class ApacheFopApp {

    public static void main(String[] args) {
        // Parse options
        CommandLine cmd = parseCli(args);

        PdfGenerator fopPdfGenerator = new FopPdfGenerator();
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("SIGNATURE.ORG", "МИЦ ПФР");
        parameters.put("CERTIFICATE", "sgs3453dfge56456");
        parameters.put("PUBLISHER", "ПФР");
        parameters.put("CERTIFICATE.DATEFROM", "20.01.2021");
        parameters.put("CERTIFICATE.DATETO", "20.01.2023");
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder;
        try {
            builder = factory.newDocumentBuilder();
            Document document = builder.parse(new InputSource(new StringReader("<?xml version=\"1.0\" ?><classifier><row id=\"151\">п.1 ст.28.1 ФЗ от 24.11.1995 №181-ФЗ \"О социальной защите инвалидов в Российской Федерации\"</row><row id=\"1\">п. 6 ч. 1 ст. 32 ФЗ от 28 декабря 2013 г. № 400-ФЗ «О страховых пенсиях»</row></classifier>")));
            parameters.put("PAYMENTS.CLASSIFIER", document);
        } catch (Exception e) {
            e.printStackTrace();
        }
        try (FileOutputStream pdfOutput = new FileOutputStream(cmd.getOptionValue("output"))) {
            fopPdfGenerator.createPdfFile(cmd.getOptionValue("datafile"), cmd.getOptionValue("stylefile"),
                pdfOutput, parameters
            );
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        System.exit(0);

    }

    private static CommandLine parseCli(String[] args) {
        Options options = new Options();

        Option style = new Option("s", "stylefile", true, "style file path");
        style.setRequired(true);
        options.addOption(style);

        Option xml = new Option("d", "datafile", true, "data xml file path");
        xml.setRequired(true);
        options.addOption(xml);

        Option output = new Option("o", "output", true, "output file");
        output.setRequired(true);
        options.addOption(output);

        CommandLineParser parser = new DefaultParser();
        HelpFormatter formatter = new HelpFormatter();
        CommandLine cmd;
        try {
            return parser.parse(options, args);
        } catch (ParseException e) {
            log.error(e.getMessage(), e);
            formatter.printHelp("App", options);
            System.exit(1);
        }
        return null;
    }
}
