import {Component, OnDestroy, OnInit} from '@angular/core';
import {ActivatedRoute, Params, Router} from '@angular/router';
import {ToastrService} from 'ngx-toastr';
import {MerkDeviceService} from '../merk-device.service';
import {Subscription} from 'rxjs';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import {MerkDevice} from '../../../../entity/merk-device.model';

@Component({
  selector: 'app-update-merk-device',
  templateUrl: './update-merk-device.component.html',
  styleUrls: ['./update-merk-device.component.scss']
})
export class UpdateMerkDeviceComponent implements OnInit, OnDestroy {

  private subcribeTopic: Subscription;
  form: FormGroup;
  submitted = false;

  constructor(
    private _router: Router,
    private _service: MerkDeviceService,
    private _activeRoute: ActivatedRoute,
    private _toastr: ToastrService,
    private _formBuilder: FormBuilder) {
  }

  ngOnInit() {
    this.form = new FormGroup({
      id: this._formBuilder.control('', Validators.required),
      name: this._formBuilder.control('', Validators.required),
      description: this._formBuilder.control('')
    });

    this.subcribeTopic = this._activeRoute.params.subscribe((params: Params) => {
      const id = params['id'];
      this._service.getChangeTypes(id).subscribe((response: any) => {
        if (response.status === 204) {
          this._router.navigate(['master', 'merk-device']);
        } else {
          const value: MerkDevice = response.body;
          console.log(value);
          this.form.setValue({
              'id': value.id,
              'name': value.name,
              'description': value.description
            }
          );
        }
      });
    });
  }

  send(data): void {
    this.submitted = true;
    if (this.form.invalid) {
      this._toastr.warning('Field Not Allowed Empty', 'Can\'t Update Change Type',
        {
          timeOut: 5000
        });
      return;
    }
    const value: MerkDevice = this.form.value;
    this._service.update(value).subscribe(resp => {
      this._toastr.info('Change a v of device', 'Update Success');
      this._router.navigate(['master', 'merk-device']);
    }, error => {
      this._toastr.warning('Cant Update a merk of device', 'Oppss...');
      console.error('Can\'t be saved');
    });
  }

  get f() {
    return this.form.controls;
  }

  ngOnDestroy(): void {
    this.subcribeTopic.unsubscribe();
  }

}
