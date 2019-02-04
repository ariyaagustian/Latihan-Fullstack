import {Injectable} from '@angular/core';
import {NavigationEnd, Router} from '@angular/router';
import {filter} from 'rxjs/operators';

@Injectable()
export class RoutingStateService {
  private history = [];

  constructor(
    private router: Router) {
  }

  public loadRouting(): void {
    this.router.events
      .pipe(filter(event => event instanceof NavigationEnd))
      .subscribe(({urlAfterRedirects}: NavigationEnd) => {

        this.history = [...this.history, urlAfterRedirects];
      });
  }

  public getHistory(): string[] {
    return this.history;
  }

  public getPreviousUrl(): string {
    return this.history[this.history.length - 2] || '/index';
  }

  public removeUrlDuplicate(arr) {
    const unique = [];
    for (let i = 0; i < arr.length; i++) {
      if (unique.indexOf(arr[i]) === -1) {
        unique.push(arr[i]);
      }
    }
    console.log(unique);
    return unique;

  }
}
