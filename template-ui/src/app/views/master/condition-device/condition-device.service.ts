import {Injectable} from '@angular/core';
import {HttpClient, HttpParams} from '@angular/common/http';
import {environment} from '../../../../environments/environment';
import {DatatablesModelResponse} from '../../../_model/datatables';
import {ConditionDevice} from '../../../entity/condition-device.model';

@Injectable()
export class ConditionDeviceService {

  constructor(private _http: HttpClient) {
  }

  public datatables(value: ConditionDevice, datatablesParameters: any) {
    let params = new HttpParams();
    params = params.append('start', datatablesParameters.start);
    params = params.append('length', datatablesParameters.length);
    params = params.append('draw', datatablesParameters.draw);
    params = params.append('order[0][column]', datatablesParameters.order[0]['column']);
    params = params.append('order[0][dir]', datatablesParameters.order[0]['dir']);

    return this._http
      .post<DatatablesModelResponse>(
        `${environment.supportDeviceApi}/master/condition-device/datatables`,
        value, {params: params}
      );
  }

  public save(value: ConditionDevice) {
    return this._http.post(`${environment.supportDeviceApi}/master/condition-device/`, value);
  }

  public update(value: ConditionDevice) {
    return this._http.put(`${environment.supportDeviceApi}/master/condition-device/`, value);
  }


  public getChangeTypes(id: number) {
    return this._http.get(`${environment.supportDeviceApi}/master/condition-device/${id}`, {observe: 'response'});
  }

  public remove(id: number) {
    return this._http.delete(`${environment.supportDeviceApi}/master/condition-device/${id}`, {observe: 'response'});
  }
}
