import {NgModule} from '@angular/core';
import {FormsModule} from '@angular/forms';
import {BsDropdownModule} from 'ngx-bootstrap/dropdown';
import {ButtonsModule} from 'ngx-bootstrap/buttons';

import {WelcomeComponent} from './welcome.component';
import {WelcomeService} from './welcome.service';
import {HTTP_INTERCEPTORS} from '@angular/common/http';
import {AuthenticationInterceptor} from '../../_auth/auth.interceptor';
import {WelcomeRoutingModule} from './welcome-routing.module';

@NgModule({
  imports: [
    FormsModule,
    WelcomeRoutingModule,
    BsDropdownModule,
    ButtonsModule.forRoot()
  ],
  declarations: [WelcomeComponent],
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: AuthenticationInterceptor,
      multi: true
    },
    WelcomeService
  ]
})
export class WelcomeModule {
}
