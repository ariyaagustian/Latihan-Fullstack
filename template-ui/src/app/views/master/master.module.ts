import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';

import {MasterRouting} from './master.routing';
import {ListCategoryDeviceComponent} from './category-device/list-category-device/list-category-device.component';
import {NewCategoryDeviceComponent} from './category-device/new-category-device/new-category-device.component';
import {UpdateCategoryDeviceComponent} from './category-device/update-category-device/update-category-device.component';
import {HTTP_INTERCEPTORS, HttpClient, HttpClientModule} from '@angular/common/http';
import {ReactiveFormsModule} from '@angular/forms';
import {CategoryDeviceService} from './category-device/category-device.service';
import {ColorDeviceService} from './color-device/color-device.service';
import {AuthenticationInterceptor} from '../../_auth/auth.interceptor';
import {DataTablesModule} from 'angular-datatables';
import {TranslateHttpLoader} from '@ngx-translate/http-loader';
import {TranslateLoader, TranslateModule} from '@ngx-translate/core';
import {AlertModule, ModalModule} from 'ngx-bootstrap';
import {Ng4LoadingSpinnerModule} from 'ng4-loading-spinner';
import {ListColorDeviceComponent} from './color-device/list-color-device/list-color-device.component';
import {NewColorDeviceComponent} from './color-device/new-color-device/new-color-device.component';
import {UpdateColorDeviceComponent} from './color-device/update-color-device/update-color-device.component';
import {ListConditionDeviceComponent} from './condition-device/list-condition-device/list-condition-device.component';
import {NewConditionDeviceComponent} from './condition-device/new-condition-device/new-condition-device.component';
import {UpdateConditionDeviceComponent} from './condition-device/update-condition-device/update-condition-device.component';
import {ConditionDeviceService} from './condition-device/condition-device.service';
import {ListMerkDeviceComponent} from './merk-device/list-merk-device/list-merk-device.component';
import {NewMerkDeviceComponent} from './merk-device/new-merk-device/new-merk-device.component';
import {UpdateMerkDeviceComponent} from './merk-device/update-merk-device/update-merk-device.component';
import {MerkDeviceService} from './merk-device/merk-device.service';
import {UnitCapacityDeviceService} from './unit-capacity-device/unit-capacity-device.service';
import {ListUnitCapacityDeviceComponent} from './unit-capacity-device/list-unit-capacity-device/list-unit-capacity-device.component';
import {NewUnitCapacityDeviceComponent} from './unit-capacity-device/new-unit-capacity-device/new-unit-capacity-device.component';
import {UpdateUnitCapacityDeviceComponent} from './unit-capacity-device/update-unit-capacity-device/update-unit-capacity-device.component';
import {ListStatusLoanDeviceComponent} from './status-loan-device/list-status-loan-device/list-status-loan-device.component';
import {NewStatusLoanDeviceComponent} from './status-loan-device/new-status-loan-device/new-status-loan-device.component';
import {UpdateStatusLoanDeviceComponent} from './status-loan-device/update-status-loan-device/update-status-loan-device.component';
import {StatusLoanDeviceService} from './status-loan-device/status-loan-device.service';
import {ListDeviceComponent} from './device/list-device/list-device.component';
import {NewDeviceComponent} from './device/new-device/new-device.component';
import {UpdateDeviceComponent} from './device/update-device/update-device.component';
import {DeviceService} from './device/device.service';

export function HttpLoaderFactory(http: HttpClient) {
  return new TranslateHttpLoader(http);
}

@NgModule({
  imports: [
    CommonModule,
    HttpClientModule,
    ReactiveFormsModule,
    DataTablesModule,
    MasterRouting,
    AlertModule.forRoot(),
    Ng4LoadingSpinnerModule.forRoot(),
    ModalModule.forRoot(),
    TranslateModule.forChild({
      loader: {
        provide: TranslateLoader,
        useFactory: HttpLoaderFactory,
        deps: [HttpClient]
      }
    }),
  ],
  declarations: [
    ListCategoryDeviceComponent,
    NewCategoryDeviceComponent,
    UpdateCategoryDeviceComponent,
    ListColorDeviceComponent,
    NewColorDeviceComponent,
    UpdateColorDeviceComponent,
    ListConditionDeviceComponent,
    NewConditionDeviceComponent,
    UpdateConditionDeviceComponent,
    ListMerkDeviceComponent,
    NewMerkDeviceComponent,
    UpdateMerkDeviceComponent,
    ListUnitCapacityDeviceComponent,
    NewUnitCapacityDeviceComponent,
    UpdateUnitCapacityDeviceComponent,
    ListStatusLoanDeviceComponent,
    NewStatusLoanDeviceComponent,
    UpdateStatusLoanDeviceComponent,
    ListDeviceComponent,
    NewDeviceComponent,
    UpdateDeviceComponent

  ], providers: [
    {
      provide: HTTP_INTERCEPTORS,
      multi: true,
      useClass: AuthenticationInterceptor
    },
    CategoryDeviceService,
    ColorDeviceService,
    ConditionDeviceService,
    MerkDeviceService,
    UnitCapacityDeviceService,
    StatusLoanDeviceService,
    DeviceService
  ]
})
export class MasterModule {
}
