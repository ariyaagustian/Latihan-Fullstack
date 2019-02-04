package id.co.mandiri.controller;

import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesRequest;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesResponse;
import id.co.mandiri.dto.conditionDTO.ConditionDeviceDTO;
import id.co.mandiri.dto.conditionDTO.ConditionDeviceMapperRequestNew;
import id.co.mandiri.dto.conditionDTO.ConditionDeviceMapperRequestUpdate;
import id.co.mandiri.dto.statusLoanDTO.StatusLoanDeviceDTO;
import id.co.mandiri.dto.statusLoanDTO.StatusLoanDeviceMapperRequestNew;
import id.co.mandiri.dto.statusLoanDTO.StatusLoanDeviceMapperRequestUpdate;
import id.co.mandiri.entity.ConditionDevice;
import id.co.mandiri.entity.StatusLoanDevice;
import id.co.mandiri.service.ConditionDeviceService;
import id.co.mandiri.service.StatusLoanDeviceService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/master/status-loan-device")
public class StatusLoanDeviceController {

    @Autowired
    private StatusLoanDeviceService service;

    @PostMapping("/datatables")
    public DataTablesResponse<StatusLoanDevice> datatables(
            @RequestParam(required = false, value = "draw", defaultValue = "0") Long draw,
            @RequestParam(required = false, value = "start", defaultValue = "0") Long start,
            @RequestParam(required = false, value = "length", defaultValue = "10") Long length,
            @RequestParam(required = false, value = "order[0][column]", defaultValue = "0") Long iSortCol0,
            @RequestParam(required = false, value = "order[0][dir]", defaultValue = "asc") String sSortDir0,
            @RequestBody(required = false) StatusLoanDevice params) {

        if (params == null) params = new StatusLoanDevice();
        log.info("draw: {}, start: {}, length: {}, type: {}", draw, start, length, params);
        return service.datatables(
                new DataTablesRequest(draw, length, start, sSortDir0, iSortCol0, params)
        );
    }

    @GetMapping("/list")
    public ResponseEntity<List<StatusLoanDevice>> list() {
        List<StatusLoanDevice> list = service.findAll();
        if (list.isEmpty())
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        else return new ResponseEntity<>(list, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<StatusLoanDevice> findById(@PathVariable("id") String id) {
        StatusLoanDevice params = service.findId(id);
        if (params != null) {
            return new ResponseEntity<>(params, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(new StatusLoanDevice(), HttpStatus.NO_CONTENT);
        }
    }

    @PostMapping("/")
    public ResponseEntity<StatusLoanDevice> save(@Valid @RequestBody StatusLoanDeviceDTO.StatusLoanDeviceRequestNewDTO params) {
        StatusLoanDevice value = StatusLoanDeviceMapperRequestNew.converter.convertToEntity(params);
        value = service.save(value);
        return new ResponseEntity<>(value, HttpStatus.CREATED);
    }

    @PutMapping("/")
    public ResponseEntity<StatusLoanDevice> update(@Valid @RequestBody StatusLoanDeviceDTO.StatusLoanDeviceRequestUpdateDTO params) {
        StatusLoanDevice value = StatusLoanDeviceMapperRequestUpdate.converter.convertToEntity(params);
        value = service.save(value);
        return new ResponseEntity<>(value, HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<StatusLoanDevice> delete(@PathVariable("id") String id) {
        boolean deleted = service.removeById(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }


}
