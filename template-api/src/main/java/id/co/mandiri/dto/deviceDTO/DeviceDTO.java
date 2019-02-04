package id.co.mandiri.dto.deviceDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

public class DeviceDTO {

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class MasterDeviceRequestNewDTO {
        @NotNull
        private String name;
        private String description;
        @NotNull
        private String category_id;
        @NotNull
        private String color_id;
        @NotNull
        private String brand_id;
        @NotNull
        private String condition_id;
        @NotNull
        private String unit_capacity_id;
        @NotNull
        private String loan_status_id;

    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class MasterDeviceRequestUpdateDTO {
        @NotNull
        private String id;
        @NotNull
        private String name;
        private String description;
        @NotNull
        private String category_id;
        @NotNull
        private String color_id;
        @NotNull
        private String brand_id;
        @NotNull
        private String condition_id;
        @NotNull
        private String unit_capacity_id;
        @NotNull
        private String loan_status_id;
    }

}
