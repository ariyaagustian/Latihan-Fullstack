package id.co.mandiri.dto.categoryDTO;

import com.maryanto.dimas.plugins.web.commons.mappers.ObjectMapper;
import id.co.mandiri.entity.CategoryDevice;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface CategoryDeviceMapperRequestUpdate extends ObjectMapper<CategoryDevice, CategoryDeviceDTO.CategoryDeviceRequestUpdateDTO> {

    CategoryDeviceMapperRequestUpdate converter = Mappers.getMapper(CategoryDeviceMapperRequestUpdate.class);
}
