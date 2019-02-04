import {Injectable} from '@angular/core';
import {HttpClient, HttpParams} from '@angular/common/http';
import {environment} from '../../../../environments/environment';
import {DatatablesModelResponse} from '../../../_model/datatables';
import {CategoryDevice} from '../../../entity/category-device.model';

@Injectable()
export class CategoryDeviceService {

  constructor(private _http: HttpClient) {
  }

  public datatables(value: CategoryDevice, datatablesParameters: any) {
    let params = new HttpParams();
    params = params.append('start', datatablesParameters.start);
    params = params.append('length', datatablesParameters.length);
    params = params.append('draw', datatablesParameters.draw);
    params = params.append('order[0][column]', datatablesParameters.order[0]['column']);
    params = params.append('order[0][dir]', datatablesParameters.order[0]['dir']);

    return this._http
      .post<DatatablesModelResponse>(
        `${environment.supportDeviceApi}/master/category-device/datatables`,
        value, {params: params}
      );
  }

  public save(value: CategoryDevice) {
    return this._http.post(`${environment.supportDeviceApi}/master/category-device/`, value);
  }

  public update(value: CategoryDevice) {
    return this._http.put(`${environment.supportDeviceApi}/master/category-device/`, value);
  }


  public getChangeTypes(id: number) {
    return this._http.get(`${environment.supportDeviceApi}/master/category-device/${id}`, {observe: 'response'});
  }

  public remove(id: number) {
    return this._http.delete(`${environment.supportDeviceApi}/master/category-device/${id}`, {observe: 'response'});
  }
}
