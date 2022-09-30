package name.zje.apachefop.controller;

import lombok.extern.slf4j.Slf4j;
import name.zje.apachefop.generator.FopPdfGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.ByteArrayOutputStream;
import java.util.HashMap;
import java.util.Map;

@RestController
@Slf4j
public class PdfGeneratorController {

    private FopPdfGenerator pdfGenerator;

    @GetMapping(value = "/pdf")
    public ResponseEntity<byte[]> generatePdf() {
        HttpStatus httpStatus = HttpStatus.BAD_REQUEST;
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            Map<String, Object> parameters = new HashMap<>();
            pdfGenerator.createPdfFile(
                new ClassPathResource("data/disability-statement.xml").getInputStream(),
                new ClassPathResource("xsl/disability-statement/disability-statement.xsl").getInputStream(),
                baos,
                parameters
            );
            httpStatus = HttpStatus.OK;
        } catch (Exception e) {
            log.error("Error create pdf: ", e);
        }
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);
        String filename = "output.pdf";
        headers.setContentDispositionFormData(filename, filename);
        headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
        ResponseEntity<byte[]> response = new ResponseEntity<>(baos.toByteArray(), headers, httpStatus);
        return response;
    }

    @Autowired
    public void setPdfGenerator(FopPdfGenerator pdfGenerator) {
        this.pdfGenerator = pdfGenerator;
    }

}
