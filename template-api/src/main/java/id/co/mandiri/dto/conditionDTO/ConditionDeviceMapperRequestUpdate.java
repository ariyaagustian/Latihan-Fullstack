package id.co.mandiri.dto.conditionDTO;

import com.maryanto.dimas.plugins.web.commons.mappers.ObjectMapper;
import id.co.mandiri.entity.CategoryDevice;
import id.co.mandiri.entity.ConditionDevice;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface ConditionDeviceMapperRequestUpdate extends ObjectMapper<ConditionDevice, ConditionDeviceDTO.ConditionDeviceRequestUpdateDTO> {

    ConditionDeviceMapperRequestUpdate converter = Mappers.getMapper(ConditionDeviceMapperRequestUpdate.class);
}
