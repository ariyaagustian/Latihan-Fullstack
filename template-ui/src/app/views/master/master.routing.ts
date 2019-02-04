import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {ListCategoryDeviceComponent} from './category-device/list-category-device/list-category-device.component';
import {NewCategoryDeviceComponent} from './category-device/new-category-device/new-category-device.component';
import {UpdateCategoryDeviceComponent} from './category-device/update-category-device/update-category-device.component';
import {ListColorDeviceComponent} from './color-device/list-color-device/list-color-device.component';
import {NewColorDeviceComponent} from './color-device/new-color-device/new-color-device.component';
import {UpdateColorDeviceComponent} from './color-device/update-color-device/update-color-device.component';
import {ListConditionDeviceComponent} from './condition-device/list-condition-device/list-condition-device.component';
import {NewConditionDeviceComponent} from './condition-device/new-condition-device/new-condition-device.component';
import {UpdateConditionDeviceComponent} from './condition-device/update-condition-device/update-condition-device.component';
import {ListMerkDeviceComponent} from './merk-device/list-merk-device/list-merk-device.component';
import {NewMerkDeviceComponent} from './merk-device/new-merk-device/new-merk-device.component';
import {UpdateMerkDeviceComponent} from './merk-device/update-merk-device/update-merk-device.component';
import {ListUnitCapacityDeviceComponent} from './unit-capacity-device/list-unit-capacity-device/list-unit-capacity-device.component';
import {NewUnitCapacityDeviceComponent} from './unit-capacity-device/new-unit-capacity-device/new-unit-capacity-device.component';
import {UpdateUnitCapacityDeviceComponent} from './unit-capacity-device/update-unit-capacity-device/update-unit-capacity-device.component';
import {ListStatusLoanDeviceComponent} from './status-loan-device/list-status-loan-device/list-status-loan-device.component';
import {NewStatusLoanDeviceComponent} from './status-loan-device/new-status-loan-device/new-status-loan-device.component';
import {UpdateStatusLoanDeviceComponent} from './status-loan-device/update-status-loan-device/update-status-loan-device.component';
import {UpdateDeviceComponent} from './device/update-device/update-device.component';
import {NewDeviceComponent} from './device/new-device/new-device.component';
import {ListDeviceComponent} from './device/list-device/list-device.component';

const routes: Routes = [
  {
    path: '',
    data: {
      title: 'Master'
    },
    children: [
      {
        path: 'category-device',
        component: ListCategoryDeviceComponent,
        data: {
          title: 'Category of Devices'
        }
      },
      {
        path: 'category-device/new',
        component: NewCategoryDeviceComponent,
        data: {
          title: 'New category of device'
        }
      },
      {
        path: 'category-device/:id',
        component: UpdateCategoryDeviceComponent,
        data: {
          title: 'Update a category of device'
        }
      },
      {
        path: 'condition-device',
        component: ListConditionDeviceComponent,
        data: {
          title: 'Condition of Devices'
        }
      },
      {
        path: 'condition-device/new',
        component: NewConditionDeviceComponent,
        data: {
          title: 'New Condition of device'
        }
      },
      {
        path: 'condition-device/:id',
        component: UpdateConditionDeviceComponent,
        data: {
          title: 'Update a Condition of device'
        }
      },
      {
        path: 'color-device',
        component: ListColorDeviceComponent,
        data: {
          title: 'Color of Devices'
        }
      },
      {
        path: 'color-device/new',
        component: NewColorDeviceComponent,
        data: {
          title: 'New Color of device'
        }
      },
      {
        path: 'color-device/:id',
        component: UpdateColorDeviceComponent,
        data: {
          title: 'Update a Color of device'
        }
      },
      {
        path: 'merk-device',
        component: ListMerkDeviceComponent,
        data: {
          title: 'Merk of Devices'
        }
      },
      {
        path: 'merk-device/new',
        component: NewMerkDeviceComponent,
        data: {
          title: 'New Merk of device'
        }
      },
      {
        path: 'merk-device/:id',
        component: UpdateMerkDeviceComponent,
        data: {
          title: 'Update a Merk of device'
        }
      },
      {
        path: 'unit-capacity-device',
        component: ListUnitCapacityDeviceComponent,
        data: {
          title: 'unit-capacity of Devices'
        }
      },
      {
        path: 'unit-capacity-device/new',
        component: NewUnitCapacityDeviceComponent,
        data: {
          title: 'New unit-capacity of device'
        }
      },
      {
        path: 'unit-capacity-device/:id',
        component: UpdateUnitCapacityDeviceComponent,
        data: {
          title: 'Update a unit-capacity of device'
        }
      },
      {
        path: 'status-loan-device',
        component: ListStatusLoanDeviceComponent,
        data: {
          title: 'status loan of Devices'
        }
      },
      {
        path: 'status-loan-device/new',
        component: NewStatusLoanDeviceComponent,
        data: {
          title: 'New status Loan of device'
        }
      },
      {
        path: 'status-loan-device/:id',
        component: UpdateStatusLoanDeviceComponent,
        data: {
          title: 'Update a status Loan of device'
        }
      },
      {
        path: 'device',
        component: ListDeviceComponent,
        data: {
          title: 'List of Devices'
        }
      },
      {
        path: 'device/new',
        component: NewDeviceComponent,
        data: {
          title: 'New device'
        }
      },
      {
        path: 'device/:id',
        component: UpdateDeviceComponent,
        data: {
          title: 'Update device'
        }
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class MasterRouting {
}
