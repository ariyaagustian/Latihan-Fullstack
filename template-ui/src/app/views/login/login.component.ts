import {Component, Inject} from '@angular/core';
import {FormBuilder, FormControl, FormGroup, Validators} from '@angular/forms';
import {AuthenticationService} from '../../_services/authentication.service';
import {Authentication, Token} from '../../_auth/auth.model';
import {Router} from '@angular/router';
import {ToastrService} from 'ngx-toastr';
import {environment} from '../../../environments/environment';
import {CookieService} from 'ngx-cookie-service';
import {DOCUMENT} from '@angular/platform-browser';

@Component({
  selector: 'app-dashboard',
  templateUrl: 'login.component.html',
  styleUrls: ['login.component.scss']
})
export class LoginComponent {

  public permittedViewIds = 'viewIds';
  private user: Authentication;
  public basePath = environment.basePath;
  public backgroundImage = this.basePath + 'assets/mandiri/img/background.jpg';
  public styleHeaderLogin = {
    'background-image': `url(${this.backgroundImage})`,
    'background-position': 'center',
    'background-repeat': 'no-repeat',
    'background-size': 'cover'
  };

  loginPage: FormGroup = new FormGroup({
    username: new FormControl(),
    password: new FormControl()
  });

  constructor(private _authService: AuthenticationService,
              private _router: Router,
              private fb: FormBuilder,
              private toastr: ToastrService,
              private cookieService: CookieService, @Inject(DOCUMENT) private document: Document) {
    this.createForm();
  }

  login(_event) {
    document.getElementById('login-loader').style.display = 'inline';
    this.user = this.loginPage.value;
    this._authService.authenticate(this.user)
      .subscribe(data => {
        const token: Token = data;
        const tomorrow = new Date();
        const path = '';
        tomorrow.setDate(tomorrow.getDate() + 1);
        console.log(tomorrow);
        this.cookieService.set('access_token', token.access_token, tomorrow, path, 'localhost', false);
        this._authService.setToken(token);
        this._router.navigate(['/welcome']);
        this._authService.getViewIds(+this._authService.currentUser.user.id).subscribe((resp: any) => {
          window.localStorage.setItem(this.permittedViewIds, JSON.stringify(resp.body));
        });
        console.log(window.localStorage.getItem('viewIds'));
        this._authService.remysLogin(token.access_token).subscribe((sessionId: any) => {
          console.log(sessionId);
          const jsessionid = sessionId['sessionId'];
          console.log(jsessionid);
          console.log(this.document.location.hostname);
          this.cookieService.set('JSESSIONID', jsessionid);
        });
      }, error => {
        console.log(error);
        document.getElementById('login-loader').style.display = 'none';
        if (error.error.error_description === 'Incorrect result size: expected 1, actual 0') {
          this.toastr.warning('User Tidak Terdaftar', 'Login Error');
        } else if (error.error.error_description === 'User is disabled') {
          this.toastr.warning('Akun Terblokir', 'Login Error');
        } else {
          if (error.error.error_description == null ||
            error.error.error_description === undefined ||
            error.error.error_description.length > 100) {
            this.toastr.warning('Hubungi Admin', 'Login Error');
          } else {
            this.toastr.warning(error.error.error_description);
          }
        }
      });
  }

  createForm() {
    this.loginPage = this.fb.group({
      username: ['', Validators.required],
      password: ['', Validators.required]
    });
  }

  register() {
    this.document.location.href = `${environment.remysUrlDeploy}/web-application-face/registerUser.xhtml`;
  }
}
