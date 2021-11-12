package name.zje.apachefop.webapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = "name.zje.apachefop")
public class ApacheFopApplication {

    public static void main(String[] args) {
        SpringApplication.run(ApacheFopApplication.class, args);
    }

}
