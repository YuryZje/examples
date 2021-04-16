package name.zje.spring.boot.rest.service;

import name.zje.spring.boot.rest.entity.PartNumber;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

@Service
public class PartNumberServiceImpl implements PartNumberService {

    private static final Map<Integer, PartNumber> PART_NUMBER_MAP = new HashMap<>();
    private static final AtomicInteger PART_NUMBER_ID = new AtomicInteger();

    @Override
    public List<PartNumber> readAll() {
        return new ArrayList<>(PART_NUMBER_MAP.values());
    }

    @Override
    public int create(PartNumber partNumber) {
        final int id = getPartNumberIdentifier();
        partNumber.setId(id);
        PART_NUMBER_MAP.put(id, partNumber);
        return id;
    }

    @Override
    public PartNumber read(int id) {
        return PART_NUMBER_MAP.get(id);
    }

    @Override
    public boolean update(PartNumber partNumber, int id) {
        if (PART_NUMBER_MAP.containsKey(id)) {
            partNumber.setId(id);
            PART_NUMBER_MAP.put(id, partNumber);
            return true;
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        return PART_NUMBER_MAP.remove(id) != null;
    }

    private int getPartNumberIdentifier() {
        return PART_NUMBER_ID.incrementAndGet();
    }
}
