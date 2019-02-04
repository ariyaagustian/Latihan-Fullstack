package id.co.mandiri.controller;

import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesRequest;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesResponse;
import id.co.mandiri.dto.colorDTO.ColorDeviceDTO;
import id.co.mandiri.dto.colorDTO.ColorDeviceMapperRequestNew;
import id.co.mandiri.dto.colorDTO.ColorDeviceMapperRequestUpdate;
import id.co.mandiri.dto.merkDTO.MerkDeviceDTO;
import id.co.mandiri.dto.merkDTO.MerkDeviceMapperRequestNew;
import id.co.mandiri.dto.merkDTO.MerkDeviceMapperRequestUpdate;
import id.co.mandiri.entity.CategoryDevice;
import id.co.mandiri.entity.ColorDevice;
import id.co.mandiri.entity.MerkDevice;
import id.co.mandiri.service.ColorDeviceService;
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
@RequestMapping("/api/master/merk-device")
public class MerkDeviceController {

    @Autowired
    private MerkDeviceService service;

    @PostMapping("/datatables")
    public DataTablesResponse<MerkDevice> datatables(
            @RequestParam(required = false, value = "draw", defaultValue = "0") Long draw,
            @RequestParam(required = false, value = "start", defaultValue = "0") Long start,
            @RequestParam(required = false, value = "length", defaultValue = "10") Long length,
            @RequestParam(required = false, value = "order[0][column]", defaultValue = "0") Long iSortCol0,
            @RequestParam(required = false, value = "order[0][dir]", defaultValue = "asc") String sSortDir0,
            @RequestBody(required = false) MerkDevice params) {

        if (params == null) params = new MerkDevice();
        log.info("draw: {}, start: {}, length: {}, type: {}", draw, start, length, params);
        return service.datatables(
                new DataTablesRequest(draw, length, start, sSortDir0, iSortCol0, params)
        );
    }

    @GetMapping("/list")
    public ResponseEntity<List<MerkDevice>> list() {
        List<MerkDevice> list = service.findAll();
        if (list.isEmpty())
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        else return new ResponseEntity<>(list, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<MerkDevice> findById(@PathVariable("id") String id) {
        MerkDevice params = service.findId(id);
        if (params != null) {
            return new ResponseEntity<>(params, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(new MerkDevice(), HttpStatus.NO_CONTENT);
        }
    }

    @PostMapping("/")
    public ResponseEntity<MerkDevice> save(@Valid @RequestBody MerkDeviceDTO.MerkDeviceRequestNewDTO params) {
        MerkDevice value = MerkDeviceMapperRequestNew.converter.convertToEntity(params);
        value = service.save(value);
        return new ResponseEntity<>(value, HttpStatus.CREATED);
    }

    @PutMapping("/")
    public ResponseEntity<MerkDevice> update(@Valid @RequestBody MerkDeviceDTO.MerkDeviceRequestUpdateDTO params) {
        MerkDevice value = MerkDeviceMapperRequestUpdate.converter.convertToEntity(params);
        value = service.save(value);
        return new ResponseEntity<>(value, HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<MerkDevice> delete(@PathVariable("id") String id) {
        boolean deleted = service.removeById(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }


}
