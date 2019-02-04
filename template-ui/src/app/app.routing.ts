import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
// Import Containers
import {DefaultLayoutComponent} from './containers';
import {AuthGuard} from './_auth/auth.guard';
import {LoginComponent} from './views/login/login.component';
import {LogoutComponent} from './views/logout/logout.component';

export const routes: Routes = [
  {
    path: '',
    redirectTo: 'dashboard',
    pathMatch: 'full',
    canActivate: [AuthGuard]
  },
  {
    path: 'welcome',
    redirectTo: 'welcome',
    pathMatch: 'full',
    canActivate: [AuthGuard]
  },
  {
    path: 'login',
    component: LoginComponent,
    data: {
      title: 'Login Page'
    }
  },
  {
    path: 'logout',
    component: LogoutComponent,
    data: {
      title: 'Logout Page'
    }
  },
  {
    path: '',
    component: DefaultLayoutComponent,
    canActivate: [AuthGuard],
    data: {
      title: 'Home'
    },
    children: [
      {
        path: 'welcome',
        loadChildren: './views/welcome/welcome.module#WelcomeModule'
      },
      {
        path: 'dashboard',
        loadChildren: './views/dashboard/dashboard.module#DashboardModule'
      },
      {
        path: 'master',
        loadChildren: './views/master/master.module#MasterModule'
      },
    ]
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {
}
