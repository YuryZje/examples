package zje.name.kafka.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.support.SendResult;
import org.springframework.util.concurrent.ListenableFuture;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import zje.name.kafka.dto.PartNumberDto;

@RestController
@RequestMapping("message")
public class MessageController {

    @Autowired
    private KafkaTemplate<Long, PartNumberDto> kafkaTemplate;

    @PostMapping
    public void sendMessage(Long messageId, String partNumberId, String partName, String partNumber) {
        PartNumberDto partNumberDto = new PartNumberDto();
        partNumberDto.setId(Integer.parseInt(partNumberId));
        partNumberDto.setName(partName);
        partNumberDto.setNumber(partNumber);
        ListenableFuture<SendResult<Long, PartNumberDto>> future = kafkaTemplate.send("message", messageId, partNumberDto);
        future.addCallback(System.out::println, System.err::println);
        kafkaTemplate.flush();
    }
}
