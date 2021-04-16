package name.zje.spring.boot.rest.controller;

import name.zje.spring.boot.rest.entity.PartNumber;
import name.zje.spring.boot.rest.service.PartNumberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class PartNumberController {

    private final PartNumberService partNumberService;

    @Autowired
    public PartNumberController(PartNumberService partNumberService) {
        this.partNumberService = partNumberService;
    }

    @PostMapping(value = "/partnumbers")
    public ResponseEntity<?> create(@RequestBody PartNumber partNumber) {
        partNumberService.create(partNumber);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping(value = "/partnumbers")
    public ResponseEntity<List<PartNumber>> readAll() {

        final List<PartNumber> partNumbers = partNumberService.readAll();

        return partNumbers != null && !partNumbers.isEmpty()
                ? new ResponseEntity<>(partNumbers, HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping(value = "/partnumbers/{id}")
    public ResponseEntity<PartNumber> read(@PathVariable(name = "id") int id) {
        final PartNumber partNumber = partNumberService.read(id);

        return partNumber != null
            ? new ResponseEntity<>(partNumber, HttpStatus.OK)
            : new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @PutMapping(value = "/partnumbers/{id}")
    public ResponseEntity<?> update(@PathVariable(name = "id") int id, @RequestBody PartNumber partNumber) {
        final boolean updated = partNumberService.update(partNumber, id);

        return updated
            ? new ResponseEntity<>(HttpStatus.OK)
            : new ResponseEntity<>(HttpStatus.NOT_MODIFIED);
    }

    @DeleteMapping(value = "/partnumbers/{id}")
    public ResponseEntity<?> delete(@PathVariable(name = "id") int id) {
        final boolean deleted = partNumberService.delete(id);

        return deleted
            ? new ResponseEntity<>(HttpStatus.OK)
            : new ResponseEntity<>(HttpStatus.NOT_MODIFIED);
    }
}
