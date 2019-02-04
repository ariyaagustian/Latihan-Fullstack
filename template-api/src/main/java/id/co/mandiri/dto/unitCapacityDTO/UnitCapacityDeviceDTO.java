package id.co.mandiri.dto.unitCapacityDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

public class UnitCapacityDeviceDTO {

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class UnitCapacityDeviceRequestNewDTO {
        @NotNull
        private String name;
        private String description;
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class UnitCapacityDeviceRequestUpdateDTO {
        @NotNull
        private String id;
        @NotNull
        private String name;
        private String description;
    }

}
