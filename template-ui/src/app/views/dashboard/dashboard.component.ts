import {Component, OnInit} from '@angular/core';
import {getStyle, hexToRgba} from '@coreui/coreui/js/src/utilities/';
import {CustomTooltips} from '@coreui/coreui-plugin-chartjs-custom-tooltips/js/';
import {AuthenticationService} from '../../_services/authentication.service';
import {Router} from '@angular/router';
import {ToastrService} from 'ngx-toastr';

@Component({
  templateUrl: 'dashboard.component.html'
})
export class DashboardComponent implements OnInit {

  constructor(private _userService: AuthenticationService, private _router: Router, private _toastr: ToastrService) {
  }

  ngOnInit(): void {
    this._userService.checkToken(this._userService.currentUser.access_token).subscribe((resp: any) => {
      console.log(this._userService.currentUser);
    }, error => {
      this._router.navigate(['../login']);
      this._userService.logout().subscribe((resp: any) => {
        this._toastr.warning('Please Login', 'Session has Expired');
        localStorage.removeItem('currentUser');
        localStorage.removeItem('k01mNd912mHDasd123ccQOdp');
      }, error => {
        this._toastr.warning('Please Login', 'Session has Expired');
        localStorage.removeItem('currentUser');
        localStorage.removeItem('k01mNd912mHDasd123ccQOdp');
      });
    });
  }
}
