package name.zje.kafka;

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.kafka.annotation.KafkaListener;
import name.zje.kafka.dto.PartNumberDto;

@SpringBootApplication
public class KafkaApplication {

    @KafkaListener(topics = "message")
    public void messageListener(ConsumerRecord<Long, PartNumberDto> record) {
        System.out.println(record.partition());
        System.out.println(record.key());
        System.out.println(record.value());
    }

    public static void main(String[] args) {
        SpringApplication.run(KafkaApplication.class, args);
    }

}
