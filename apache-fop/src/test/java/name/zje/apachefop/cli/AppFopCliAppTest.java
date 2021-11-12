package name.zje.apachefop.cli;

import name.zje.apachefop.generator.FopPdfGenerator;
import org.apache.fop.configuration.ConfigurationException;
import org.junit.Test;
import org.xml.sax.SAXException;

import javax.xml.transform.TransformerException;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Unit test for simple App.
 */
public class AppFopCliAppTest {

    @Test
    public void testGeneratePdf() {

        FopPdfGenerator fopPdfGenerator = new FopPdfGenerator();
        Map<String, String> parameters = new HashMap<>();
        try (FileOutputStream pdfOutput = new FileOutputStream("cars.pdf")) {
            fopPdfGenerator.createPdfFile("src/main/resources/data/cars.xml", "src/main/resources/xslt/cars-template.xsl",
                pdfOutput, parameters
            );
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (TransformerException e) {
            e.printStackTrace();
        } catch (SAXException e) {
            e.printStackTrace();
        } catch (ConfigurationException e) {
            e.printStackTrace();
        }

    }
}
