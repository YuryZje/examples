package name.zje.spring.boot.rest.service;

import name.zje.spring.boot.rest.entity.PartNumber;

import java.util.List;

public interface PartNumberService {

    List<PartNumber> readAll();

    int create(PartNumber partNumber);

    PartNumber read(int id);

    boolean update(PartNumber partNumber, int id);

    boolean delete(int id);
}
