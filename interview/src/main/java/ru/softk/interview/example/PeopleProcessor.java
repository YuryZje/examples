package ru.softk.interview.example;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.Set;

@Component
public class PeopleProcessor {

    @Autowired
    private PeopleHandler peopleHandler;

    public String saveToCsv(People p, String region) {
        try {
            List<Object> peopleList = peopleHandler.handle(region);
            if (peopleList.contains(p)) {
                return "1";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "2";
    }

    public List<Object> showPeople() {
        return peopleHandler.handle();
    }

    public int saveToPdf() {
        List<Object> peopleList = peopleHandler.handle();
        return peopleList.size();
    }

    static class People {

        String name;

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            People people = (People) o;
            return Objects.equals(name, people.name);
        }

        @Override
        public int hashCode() {
            return Objects.hash(name);
        }
    }

    public static void main(String[] args) {
        Set<People> p = new HashSet<>();
        for (int i = 0; i < 11; i++) {
            p.add(new People());
        }

    }
}