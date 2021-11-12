package name.zje.camel.rest.controller;

import name.zje.camel.rest.entity.PartNumber;
import name.zje.camel.rest.service.PartNumberService;
import org.apache.camel.Exchange;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;


@Service("partNumberController")
public class PartNumberController {

    private final PartNumberService partNumberService;

    @Autowired
    public PartNumberController(PartNumberService partNumberService) {
        this.partNumberService = partNumberService;
    }

    public void create(Exchange exchange) {
        PartNumber partNumber = exchange.getIn().getBody(PartNumber.class);
        partNumberService.create(partNumber);
        exchange.getIn().setHeader(Exchange.HTTP_RESPONSE_CODE, HttpStatus.CREATED.value());
    }

    public List<PartNumber> readAll(Exchange exchange) {

        final List<PartNumber> partNumbers = partNumberService.readAll();
        if (partNumbers != null && !partNumbers.isEmpty()) {
            exchange.getIn().setHeader(Exchange.HTTP_RESPONSE_CODE, HttpStatus.OK.value());
        } else {
            exchange.getIn().setHeader(Exchange.HTTP_RESPONSE_CODE, HttpStatus.NO_CONTENT.value());
        }
        return partNumbers;
    }

    public PartNumber read(int id, Exchange exchange) {
        final PartNumber partNumber = partNumberService.read(id);
        if (partNumber != null) {
            exchange.getIn().setHeader(Exchange.HTTP_RESPONSE_CODE, HttpStatus.OK.value());
        } else {
            exchange.getIn().setHeader(Exchange.HTTP_RESPONSE_CODE, HttpStatus.NO_CONTENT.value());
        }
        return partNumber;
    }

    public ResponseEntity<?> update(int id, Exchange exchange) {
        PartNumber p = exchange.getIn().getBody(PartNumber.class);
        final boolean updated = partNumberService.update(p, id);

        return updated
            ? new ResponseEntity<>(HttpStatus.OK)
            : new ResponseEntity<>(HttpStatus.NOT_MODIFIED);
    }

    public ResponseEntity<?> delete(int id) {
        final boolean deleted = partNumberService.delete(id);

        return deleted
            ? new ResponseEntity<>(HttpStatus.OK)
            : new ResponseEntity<>(HttpStatus.NOT_MODIFIED);
    }
}
