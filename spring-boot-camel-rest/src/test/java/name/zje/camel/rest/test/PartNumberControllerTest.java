package name.zje.camel.rest.test;

import name.zje.camel.rest.entity.PartNumber;
import org.apache.camel.CamelContext;
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

import static org.assertj.core.internal.bytebuddy.matcher.ElementMatchers.anyOf;
import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.either;

@ExtendWith(SpringExtension.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class PartNumberControllerTest {

    private static final String CONTEXT = "/parts";

    @Autowired
    private TestRestTemplate restTemplate;

    @Autowired
    private CamelContext camelContext;

    @Test
    void whenPartNumbers_thenStatus204() {
        ResponseEntity<List<PartNumber>> response = restTemplate.exchange(CONTEXT + "/partnumbers", HttpMethod.GET, null,
            new ParameterizedTypeReference<>() {
            });
        assertThat(response.getStatusCode(), either(is(HttpStatus.OK)).or(is(HttpStatus.NO_CONTENT)));
        List<PartNumber> partNumbers = response.getBody();
        assertThat(partNumbers, is(notNullValue()));
        partNumbers.forEach(p -> {
            Map<String, Integer> params = new HashMap<>();
            params.put("id", p.getId());
            restTemplate.delete(CONTEXT + "/partnumbers/{id}", params);
        });
        response = restTemplate.exchange(CONTEXT + "/partnumbers", HttpMethod.GET, null,
            new ParameterizedTypeReference<>() {
            });
        assertThat(response.getStatusCode(), is(HttpStatus.NO_CONTENT));
    }

    @Test
    void createPartNumbers_thenStatus201() {
        HttpEntity<PartNumber> request = new HttpEntity<>(new PartNumber(Integer.MIN_VALUE, "QF345AF"));
        ResponseEntity<?> response = restTemplate.exchange(CONTEXT + "/partnumbers", HttpMethod.POST, request,
            new ParameterizedTypeReference<>() {
            });
        assertThat(response.getStatusCode(), is(HttpStatus.CREATED));
    }

    @Test
    void whenPartNumbers_thenStatus200() {
        HttpEntity<PartNumber> request = new HttpEntity<>(new PartNumber(Integer.MIN_VALUE, "QF345AF"));
        ResponseEntity<?> createResponse = restTemplate.exchange(CONTEXT + "/partnumbers", HttpMethod.POST, request,
            new ParameterizedTypeReference<>() {
            });
        assertThat(createResponse.getStatusCode(), is(HttpStatus.CREATED));
        ResponseEntity<List<PartNumber>> response = restTemplate.exchange(CONTEXT + "/partnumbers", HttpMethod.GET, null,
            new ParameterizedTypeReference<>() {
            });
        assertThat(response.getStatusCode(), is(HttpStatus.OK));
    }

    @Test
    void whenPartNumbers_thenDeleteOk() {
        HttpEntity<PartNumber> request = new HttpEntity<>(new PartNumber(Integer.MIN_VALUE, "QF345AF"));
        ResponseEntity <?> responseCreate = restTemplate.exchange(CONTEXT + "/partnumbers", HttpMethod.POST, request,
            new ParameterizedTypeReference<>() {
            });
        assertThat(responseCreate.getStatusCode(), is(HttpStatus.CREATED));
        ResponseEntity<List<PartNumber>> response = restTemplate.exchange(CONTEXT + "/partnumbers", HttpMethod.GET, null,
            new ParameterizedTypeReference<>() {
            });
        assertThat(response.getStatusCode(), is(HttpStatus.OK));
        List<PartNumber> partNumbers = response.getBody();
        assertThat(partNumbers, is(notNullValue()));
        assertThat(partNumbers.isEmpty(), is(false));
        Map<String, Integer> params = new HashMap<>();
        params.put("id", partNumbers.get(0).getId());
        ResponseEntity <?> responseDelete = restTemplate.exchange(CONTEXT + "/partnumbers/{id}", HttpMethod.DELETE, null,
            new ParameterizedTypeReference<>() {
            }, params);
        assertThat(responseDelete.getStatusCode(), is(HttpStatus.OK));
    }

    @Test
    void whenPartNumbers_thenUpdateOk() {
        HttpEntity<PartNumber> request = new HttpEntity<>(new PartNumber(Integer.MIN_VALUE, "QF345AF"));
        ResponseEntity<?> responseCreate = restTemplate.exchange(CONTEXT + "/partnumbers", HttpMethod.POST, request,
            new ParameterizedTypeReference<>() {
            });
        assertThat(responseCreate.getStatusCode(), is(HttpStatus.CREATED));
        ResponseEntity<List<PartNumber>>response = restTemplate.exchange(CONTEXT + "/partnumbers", HttpMethod.GET, null,
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
        ResponseEntity<?> updateResponse = restTemplate.exchange(CONTEXT + "/partnumbers/{id}", HttpMethod.PUT, updateRequest,
            new ParameterizedTypeReference<>() {
            }, params);
        assertThat(updateResponse.getStatusCode(), is(HttpStatus.OK));
        params.put("id", updatePartNumber.getId());
        ResponseEntity<PartNumber> partNumberResponse = restTemplate.exchange(CONTEXT + "/partnumbers/{id}", HttpMethod.GET, null,
            new ParameterizedTypeReference<>() {
            }, params);

        assertThat(partNumberResponse.getStatusCode(), is(HttpStatus.OK));
        assertThat(partNumberResponse.getBody(), is(notNullValue()));
        assertThat(partNumberResponse.getBody().getName(), equalTo(updatePartNumber.getName()));
    }
}
