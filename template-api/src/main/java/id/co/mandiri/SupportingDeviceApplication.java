package id.co.mandiri;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Import;
import springfox.bean.validators.configuration.BeanValidatorPluginsConfiguration;

@SpringBootApplication
@Import(BeanValidatorPluginsConfiguration.class)
public class SupportingDeviceApplication {

    public static void main(String[] args) {
        SpringApplication.run(SupportingDeviceApplication.class, args);
    }

}
