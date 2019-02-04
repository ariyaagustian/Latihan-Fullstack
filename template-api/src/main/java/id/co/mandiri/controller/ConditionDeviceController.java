package id.co.mandiri.controller;

import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesRequest;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesResponse;
import id.co.mandiri.dto.conditionDTO.ConditionDeviceDTO;
import id.co.mandiri.dto.conditionDTO.ConditionDeviceMapperRequestNew;
import id.co.mandiri.dto.conditionDTO.ConditionDeviceMapperRequestUpdate;
import id.co.mandiri.dto.merkDTO.MerkDeviceDTO;
import id.co.mandiri.dto.merkDTO.MerkDeviceMapperRequestNew;
import id.co.mandiri.dto.merkDTO.MerkDeviceMapperRequestUpdate;
import id.co.mandiri.entity.ConditionDevice;
import id.co.mandiri.entity.MerkDevice;
import id.co.mandiri.service.ConditionDeviceService;
import id.co.mandiri.service.MerkDeviceService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/master/condition-device")
public class ConditionDeviceController {

    @Autowired
    private ConditionDeviceService service;

    @PostMapping("/datatables")
    public DataTablesResponse<ConditionDevice> datatables(
            @RequestParam(required = false, value = "draw", defaultValue = "0") Long draw,
            @RequestParam(required = false, value = "start", defaultValue = "0") Long start,
            @RequestParam(required = false, value = "length", defaultValue = "10") Long length,
            @RequestParam(required = false, value = "order[0][column]", defaultValue = "0") Long iSortCol0,
            @RequestParam(required = false, value = "order[0][dir]", defaultValue = "asc") String sSortDir0,
            @RequestBody(required = false) ConditionDevice params) {

        if (params == null) params = new ConditionDevice();
        log.info("draw: {}, start: {}, length: {}, type: {}", draw, start, length, params);
        return service.datatables(
                new DataTablesRequest(draw, length, start, sSortDir0, iSortCol0, params)
        );
    }

    @GetMapping("/list")
    public ResponseEntity<List<ConditionDevice>> list() {
        List<ConditionDevice> list = service.findAll();
        if (list.isEmpty())
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        else return new ResponseEntity<>(list, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ConditionDevice> findById(@PathVariable("id") String id) {
        ConditionDevice params = service.findId(id);
        if (params != null) {
            return new ResponseEntity<>(params, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(new ConditionDevice(), HttpStatus.NO_CONTENT);
        }
    }

    @PostMapping("/")
    public ResponseEntity<ConditionDevice> save(@Valid @RequestBody ConditionDeviceDTO.ConditionDeviceRequestNewDTO params) {
        ConditionDevice value = ConditionDeviceMapperRequestNew.converter.convertToEntity(params);
        value = service.save(value);
        return new ResponseEntity<>(value, HttpStatus.CREATED);
    }

    @PutMapping("/")
    public ResponseEntity<ConditionDevice> update(@Valid @RequestBody ConditionDeviceDTO.ConditionDeviceRequestUpdateDTO params) {
        ConditionDevice value = ConditionDeviceMapperRequestUpdate.converter.convertToEntity(params);
        value = service.save(value);
        return new ResponseEntity<>(value, HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ConditionDevice> delete(@PathVariable("id") String id) {
        boolean deleted = service.removeById(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }


}
