package id.co.mandiri.dto.statusLoanDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

public class StatusLoanDeviceDTO {

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class StatusLoanDeviceRequestNewDTO {
        @NotNull
        private String name;
        private String description;
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class StatusLoanDeviceRequestUpdateDTO {
        @NotNull
        private String id;
        @NotNull
        private String name;
        private String description;
    }

}
