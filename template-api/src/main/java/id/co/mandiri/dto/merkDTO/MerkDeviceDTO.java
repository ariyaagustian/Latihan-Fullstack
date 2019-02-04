package id.co.mandiri.dto.merkDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

public class MerkDeviceDTO {

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class MerkDeviceRequestNewDTO {
        @NotNull
        private String name;
        private String description;
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class MerkDeviceRequestUpdateDTO {
        @NotNull
        private String id;
        @NotNull
        private String name;
        private String description;
    }

}
