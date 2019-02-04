package id.co.mandiri.dto.colorDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

public class ColorDeviceDTO {

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class ColorDeviceRequestNewDTO {
        @NotNull
        private String name;
        private String description;
        private String color_code;
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class ColorDeviceRequestUpdateDTO {
        @NotNull
        private String id;
        @NotNull
        private String name;
        private String description;
        private String color_code;
    }

}
