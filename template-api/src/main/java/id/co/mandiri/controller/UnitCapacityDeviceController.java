package id.co.mandiri.controller;

import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesRequest;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesResponse;
import id.co.mandiri.dto.statusLoanDTO.StatusLoanDeviceDTO;
import id.co.mandiri.dto.statusLoanDTO.StatusLoanDeviceMapperRequestNew;
import id.co.mandiri.dto.statusLoanDTO.StatusLoanDeviceMapperRequestUpdate;
import id.co.mandiri.dto.unitCapacityDTO.UnitCapacityDeviceDTO;
import id.co.mandiri.dto.unitCapacityDTO.UnitCapacityDeviceMapperRequestNew;
import id.co.mandiri.dto.unitCapacityDTO.UnitCapacityDeviceMapperRequestUpdate;
import id.co.mandiri.entity.StatusLoanDevice;
import id.co.mandiri.entity.UnitCapacityDevice;
import id.co.mandiri.service.StatusLoanDeviceService;
import id.co.mandiri.service.UnitCapacityDeviceService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/master/unit-capacity-device")
public class UnitCapacityDeviceController {

    @Autowired
    private UnitCapacityDeviceService service;

    @PostMapping("/datatables")
    public DataTablesResponse<UnitCapacityDevice> datatables(
            @RequestParam(required = false, value = "draw", defaultValue = "0") Long draw,
            @RequestParam(required = false, value = "start", defaultValue = "0") Long start,
            @RequestParam(required = false, value = "length", defaultValue = "10") Long length,
            @RequestParam(required = false, value = "order[0][column]", defaultValue = "0") Long iSortCol0,
            @RequestParam(required = false, value = "order[0][dir]", defaultValue = "asc") String sSortDir0,
            @RequestBody(required = false) UnitCapacityDevice params) {

        if (params == null) params = new UnitCapacityDevice();
        log.info("draw: {}, start: {}, length: {}, type: {}", draw, start, length, params);
        return service.datatables(
                new DataTablesRequest(draw, length, start, sSortDir0, iSortCol0, params)
        );
    }

    @GetMapping("/list")
    public ResponseEntity<List<UnitCapacityDevice>> list() {
        List<UnitCapacityDevice> list = service.findAll();
        if (list.isEmpty())
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        else return new ResponseEntity<>(list, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<UnitCapacityDevice> findById(@PathVariable("id") String id) {
        UnitCapacityDevice params = service.findId(id);
        if (params != null) {
            return new ResponseEntity<>(params, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(new UnitCapacityDevice(), HttpStatus.NO_CONTENT);
        }
    }

    @PostMapping("/")
    public ResponseEntity<UnitCapacityDevice> save(@Valid @RequestBody UnitCapacityDeviceDTO.UnitCapacityDeviceRequestNewDTO params) {
        UnitCapacityDevice value = UnitCapacityDeviceMapperRequestNew.converter.convertToEntity(params);
        value = service.save(value);
        return new ResponseEntity<>(value, HttpStatus.CREATED);
    }

    @PutMapping("/")
    public ResponseEntity<UnitCapacityDevice> update(@Valid @RequestBody UnitCapacityDeviceDTO.UnitCapacityDeviceRequestUpdateDTO params) {
        UnitCapacityDevice value = UnitCapacityDeviceMapperRequestUpdate.converter.convertToEntity(params);
        value = service.save(value);
        return new ResponseEntity<>(value, HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<UnitCapacityDevice> delete(@PathVariable("id") String id) {
        boolean deleted = service.removeById(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }


}
