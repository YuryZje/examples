package name.zje.camel.rest.service;


import name.zje.camel.rest.entity.PartNumber;

import java.util.List;

public interface PartNumberService {

    List<PartNumber> readAll();

    int create(PartNumber partNumber);

    PartNumber read(int id);

    boolean update(PartNumber partNumber, int id);

    boolean delete(int id);
}
