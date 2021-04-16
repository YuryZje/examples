package name.zje.spring.boot.rest;

import name.zje.spring.boot.rest.entity.PartNumber;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.hamcrest.CoreMatchers.*;
import static org.hamcrest.MatcherAssert.assertThat;

@ExtendWith(SpringExtension.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class PartNumberControllerIntegrationTests {

    @Autowired
    private TestRestTemplate restTemplate;

    @Test
    void whenPartNumbers_thenStatus204() {
        ResponseEntity<List<PartNumber>> response = restTemplate.exchange("/partnumbers", HttpMethod.GET, null,
            new ParameterizedTypeReference<>() {
            });
        assertThat(response.getStatusCode(), is(HttpStatus.OK));
        List<PartNumber> partNumbers = response.getBody();
        assertThat(partNumbers, is(notNullValue()));
        partNumbers.forEach(p -> {
            Map<String, Integer> params = new HashMap<>();
            params.put("id", p.getId());
            restTemplate.delete("/partnumbers/{id}", params);
        });
        response = restTemplate.exchange("/partnumbers", HttpMethod.GET, null,
            new ParameterizedTypeReference<>() {
            });
        assertThat(response.getStatusCode(), is(HttpStatus.NO_CONTENT));
    }

    @Test
    void createPartNumbers_thenStatus201() {
        HttpEntity<PartNumber> request = new HttpEntity<>(new PartNumber(Integer.MIN_VALUE, "QF345AF"));
        ResponseEntity<?> response = restTemplate.exchange("/partnumbers", HttpMethod.POST, request,
            new ParameterizedTypeReference<>() {
            });
        assertThat(response.getStatusCode(), is(HttpStatus.CREATED));
    }

    @Test
    void whenPartNumbers_thenStatus200() {
        HttpEntity<PartNumber> request = new HttpEntity<>(new PartNumber(Integer.MIN_VALUE, "QF345AF"));
        ResponseEntity<List<PartNumber>> response;
        response = restTemplate.exchange("/partnumbers", HttpMethod.POST, request,
            new ParameterizedTypeReference<>() {
            });
        assertThat(response.getStatusCode(), is(HttpStatus.CREATED));
        response = restTemplate.exchange("/partnumbers", HttpMethod.GET, null,
            new ParameterizedTypeReference<>() {
            });
        assertThat(response.getStatusCode(), is(HttpStatus.OK));
    }

    @Test
    void whenPartNumbers_thenDeleteOk() {
        HttpEntity<PartNumber> request = new HttpEntity<>(new PartNumber(Integer.MIN_VALUE, "QF345AF"));
        ResponseEntity<List<PartNumber>> response;
        response = restTemplate.exchange("/partnumbers", HttpMethod.POST, request,
            new ParameterizedTypeReference<>() {
            });
        assertThat(response.getStatusCode(), is(HttpStatus.CREATED));
        response = restTemplate.exchange("/partnumbers", HttpMethod.GET, null,
            new ParameterizedTypeReference<>() {
            });
        assertThat(response.getStatusCode(), is(HttpStatus.OK));
        List<PartNumber> partNumbers = response.getBody();
        assertThat(partNumbers, is(notNullValue()));
        assertThat(partNumbers.isEmpty(), is(false));
        Map<String, Integer> params = new HashMap<>();
        params.put("id", partNumbers.get(0).getId());
        response = restTemplate.exchange("/partnumbers/{id}", HttpMethod.DELETE, null,
            new ParameterizedTypeReference<>() {
            }, params);
        assertThat(response.getStatusCode(), is(HttpStatus.OK));
    }

    @Test
    void whenPartNumbers_thenUpdateOk() {
        HttpEntity<PartNumber> request = new HttpEntity<>(new PartNumber(Integer.MIN_VALUE, "QF345AF"));
        ResponseEntity<List<PartNumber>> response;
        response = restTemplate.exchange("/partnumbers", HttpMethod.POST, request,
            new ParameterizedTypeReference<>() {
            });
        assertThat(response.getStatusCode(), is(HttpStatus.CREATED));
        response = restTemplate.exchange("/partnumbers", HttpMethod.GET, null,
            new ParameterizedTypeReference<>() {
            });
        assertThat(response.getStatusCode(), is(HttpStatus.OK));
        List<PartNumber> partNumbers = response.getBody();
        assertThat(partNumbers, is(notNullValue()));
        assertThat(partNumbers.isEmpty(), is(false));
        Map<String, Integer> params = new HashMap<>();
        PartNumber updatePartNumber = partNumbers.get(0);
        params.put("id", updatePartNumber.getId());
        updatePartNumber.setName("UPDATE_NUMBER");
        HttpEntity<PartNumber> updateRequest = new HttpEntity<>(updatePartNumber);
        response = restTemplate.exchange("/partnumbers/{id}", HttpMethod.PUT, updateRequest,
            new ParameterizedTypeReference<>() {
            }, params);
        assertThat(response.getStatusCode(), is(HttpStatus.OK));
        ResponseEntity<PartNumber> updateResponse = restTemplate.exchange("/partnumbers/{id}", HttpMethod.GET, null,
            new ParameterizedTypeReference<>() {
            }, params);
        assertThat(response.getStatusCode(), is(HttpStatus.OK));
        assertThat(updateResponse.getBody(), is(notNullValue()));
        assertThat(updateResponse.getBody().getName(), equalTo(updatePartNumber.getName()));
    }
}
