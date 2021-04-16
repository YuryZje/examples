package name.zje.camel.rest.route;

import name.zje.camel.rest.controller.PartNumberController;
import name.zje.camel.rest.entity.PartNumber;
import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.model.rest.RestBindingMode;
import org.springframework.stereotype.Component;

@Component
public class RestRouteBuilder extends RouteBuilder {

    @Override
    public void configure() {

        restConfiguration()
            .component("servlet")
            .bindingMode(RestBindingMode.auto);

        rest().description("Part numbers REST service")
            .get("/partnumbers")
                .to("direct:partnumbersReadAll")
            .get("/partnumbers/{id}")
                .to("direct:partnumberRead")
            .delete("/partnumbers/{id}")
                .to("direct:partnumberDelete")
            .post("/partnumbers")
                 .type(PartNumber.class)
                 .to("direct:partnumberCreate")
            .put("/partnumbers/{id}")
                .type(PartNumber.class)
                .to("direct:partnumberUpdate");

            from("direct:partnumbersReadAll")
                .bean(PartNumberController.class, "readAll");
            from("direct:partnumberCreate")
                .bean(PartNumberController.class, "create");
            from("direct:partnumberRead")
                .bean(PartNumberController.class, "read(${header.id})");
            from("direct:partnumberDelete")
                .bean(PartNumberController.class, "delete(${header.id})");
        from("direct:partnumberUpdate")
            .bean(PartNumberController.class, "update(${header.id})");

    }
}
