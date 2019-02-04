import {Component, OnInit} from '@angular/core';
import {Router} from '@angular/router';
import {CookieService} from 'ngx-cookie-service';
import {AuthenticationService} from '../../_services/authentication.service';
import {environment} from '../../../environments/environment';

@Component({
  selector: 'app-logout',
  templateUrl: 'logout.component.html',
  styleUrls: ['logout.component.scss']
})
export class LogoutComponent implements OnInit {

  constructor(private _router: Router, private cookieService: CookieService, private _auth: AuthenticationService) {
  }

  public basePath = environment.basePath;

  ngOnInit() {
    if (localStorage.getItem('currentUser')) {
      this._auth.logout().subscribe((resp: any) => {
        console.log('Logout Atau Keluar : ');
        console.log(resp);
        localStorage.removeItem('currentUser');
        localStorage.removeItem('viewIds');
        localStorage.removeItem('3qew9reotrtagdag');
        // this._router.navigate(['login']);
      }, error => {
        console.log(error);
        localStorage.removeItem('currentUser');
        localStorage.removeItem('viewIds');
        localStorage.removeItem('3qew9reotrtagdag');
        // this._router.navigate(['/login']);
      });
    }
    window.localStorage.clear();
    window.sessionStorage.clear();
    this.cookieService.deleteAll();
    this._auth.remysLogout().subscribe((resp: any) => {
      console.log('Logout Atau Keluar Remys : ');
      console.log(resp);
      // this._router.navigate(['login']);
    });
  }

  onClickLogin() {
    this._router.navigate(['login']);
  }
}
