package name.zje.apachefop.generator;

import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.apache.fop.apps.*;
import org.apache.fop.configuration.Configuration;
import org.apache.fop.configuration.ConfigurationException;
import org.apache.fop.configuration.DefaultConfigurationBuilder;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.xml.sax.SAXException;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.URIResolver;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;

/**
 * Generate a PDF file using XML data and XSLT stylesheets
 */
 @Slf4j
 @Service
public class FopPdfGenerator implements PdfGenerator {

    private static final String FOP_CONFIG_FILE = "/fop-config/fop-config.xml";
    private static final String FOP_BASE_DIR = FopPdfGenerator.class.getResource("/").getFile();

    public void createPdfFile(String xmlDataFile, String templateFile, OutputStream pdfOutputStream, Map<String, String> parameters) throws IOException, SAXException, TransformerException, ConfigurationException {
        createPdfFile(new FileInputStream(xmlDataFile), new FileInputStream(templateFile), pdfOutputStream, parameters);
    }

    public void createPdfFile(InputStream xmlDataFile, InputStream templateFile, OutputStream pdfOutputStream,
                              Map<String, String> parameters) throws SAXException, TransformerException, ConfigurationException {
        log.info("Create pdf file ...");
        log.info("Fop base dir: " + FOP_BASE_DIR);

        //  holds references to configuration information and cached data
        //  reuse this instance if you plan to render multiple documents
        DefaultConfigurationBuilder cfgBuilder = new DefaultConfigurationBuilder();
        Configuration config = cfgBuilder.build(getClass().getResourceAsStream(FOP_CONFIG_FILE));
        FopFactoryBuilder factoryBuilder = new FopFactoryBuilder(new File(FOP_BASE_DIR).toURI()).setConfiguration(config);
        FopFactory fopFactory = factoryBuilder.build();

        FOUserAgent userAgent = fopFactory.newFOUserAgent();

        try {
            // set output format
            Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, userAgent, pdfOutputStream);

            // Load template
            TransformerFactory transformerFactory = new net.sf.saxon.TransformerFactoryImpl();
            transformerFactory.setURIResolver(new ClasspathResourceURIResolver());
            Transformer transformer = transformerFactory.newTransformer(new StreamSource(templateFile));
            if (parameters != null) {
                parameters.forEach((k, v) -> transformer.setParameter(k, v));
            }
            // Set value of parameters in stylesheet
            transformer.setParameter("version", "3.0");


            // Input for XSLT transformations
            Source xmlSource = new StreamSource(xmlDataFile);

            Result result = new SAXResult(fop.getDefaultHandler());

            transformer.transform(xmlSource, result);
        } finally {

        }
    }

    class ClasspathResourceURIResolver implements URIResolver {

        @Override
        public Source resolve(String href, String base) {
            try {
                //TODO: move to parameters
                return new StreamSource(new ClassPathResource("xsl/disability-statement/" + href).getInputStream());
            } catch (IOException e) {
                log.error("Couldn't find resource {} in {}", href, getClass().getClassLoader().getResource(".").getPath());
                throw new IllegalArgumentException("Unable to find resource.");
            }
        }
    }

}
