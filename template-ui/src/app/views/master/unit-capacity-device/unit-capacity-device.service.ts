import {Injectable} from '@angular/core';
import {HttpClient, HttpParams} from '@angular/common/http';
import {environment} from '../../../../environments/environment';
import {DatatablesModelResponse} from '../../../_model/datatables';
import {UnitCapacityDevice} from '../../../entity/unit-capacity-device.model';

@Injectable()
export class UnitCapacityDeviceService {

  constructor(private _http: HttpClient) {
  }

  public datatables(value: UnitCapacityDevice, datatablesParameters: any) {
    let params = new HttpParams();
    params = params.append('start', datatablesParameters.start);
    params = params.append('length', datatablesParameters.length);
    params = params.append('draw', datatablesParameters.draw);
    params = params.append('order[0][column]', datatablesParameters.order[0]['column']);
    params = params.append('order[0][dir]', datatablesParameters.order[0]['dir']);

    return this._http
      .post<DatatablesModelResponse>(
        `${environment.supportDeviceApi}/master/unit-capacity-device/datatables`,
        value, {params: params}
      );
  }

  public save(value: UnitCapacityDevice) {
    return this._http.post(`${environment.supportDeviceApi}/master/unit-capacity-device/`, value);
  }

  public update(value: UnitCapacityDevice) {
    return this._http.put(`${environment.supportDeviceApi}/master/unit-capacity-device/`, value);
  }


  public getChangeTypes(id: number) {
    return this._http.get(`${environment.supportDeviceApi}/master/unit-capacity-device/${id}`, {observe: 'response'});
  }

  public remove(id: number) {
    return this._http.delete(`${environment.supportDeviceApi}/master/unit-capacity-device/${id}`, {observe: 'response'});
  }
}
