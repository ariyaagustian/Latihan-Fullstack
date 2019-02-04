package id.co.mandiri.dto.categoryDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

public class CategoryDeviceDTO {

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class CategoriDeviceRequestNewDTO {
        @NotNull
        private String name;
        private String description;
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class CategoryDeviceRequestUpdateDTO {
        @NotNull
        private String id;
        @NotNull
        private String name;
        private String description;
    }

}
