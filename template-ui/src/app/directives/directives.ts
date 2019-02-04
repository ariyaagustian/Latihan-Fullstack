import {Directive, HostListener} from '@angular/core';
import {ToastrService} from 'ngx-toastr';

@Directive({
  selector: '[numberUtils]'
})
export class NumberOnlyDirective {
  constructor(private _toastr: ToastrService) {
  }

  @HostListener('keypress', ['$event'])
  onKeypress(event: any) {
    if (event.charCode > 31 && (event.charCode < 48 || event.charCode > 57)) {
      this._toastr.warning('Can\'t Input Text', 'Not Allowed',
        {
          timeOut: 4000
        });
      return false;
    } else {
      if (event.path[0].id === 'noKtp' || event.path[0].id === 'nik') {
        let maxlength = 16;
        if (event.target.value.length >= maxlength) {
          this._toastr.warning('Can\'t Input More Than 16 Digit', 'Not Allowed',
            {
              timeOut: 4000
            });
          return false;
        }
        return true;
      }
      if (event.path[0].id === 'fromYear' || event.path[0].id === 'endYear' || event.path[0].id === 'year') {
        let maxlength = 4;
        if (event.target.value.length >= maxlength) {
          this._toastr.warning('Can\'t Input More Than 4 Digit', 'Not Allowed',
            {
              timeOut: 4000
            });
          return false;
        }
        let years: number;
        years = event.target.value;
        console.log(event);
        if (event.target.value)
          return true;
      }
      if (event.path[0].id === 'homeTelephone' || event.path[0].id === 'mobile' || event.path[0].id === 'workTelephone') {
        let maxlength = 15;
        if (event.target.value.length >= maxlength) {
          this._toastr.warning('Can\'t Input More Than 15 Digit', 'Not Allowed',
            {
              timeOut: 4000
            });
          return false;
        }
        return true;
      }
      if (event.path[0].id === 'certificateNumber') {
        let maxlength = 20;
        if (event.target.value.length >= maxlength) {
          this._toastr.warning('Can\'t Input More Than 20 Digit', 'Not Allowed',
            {
              timeOut: 4000
            });
          return false;
        }
        return true;
      }
    }
  }

  @HostListener('paste', ['$event'])
  onPaste(event: any) {
    const value = event.clipboardData.getData('Text');
    const regex = new RegExp('^[0-9 ]{1,20}$');
    if (!regex.test(value)) {
      this._toastr.warning('Can\'t Paste Text', 'Not Allowed',
        {
          timeOut: 4000
        });
      return false;
    }
    return true;
  }
}

@Directive({
  selector: '[numberSymbolUtils]'
})
export class NumberSymbolDirective {
  constructor(private _toastr: ToastrService) {
  }

  @HostListener('keypress', ['$event'])
  onKeypress(event: any) {
    if (event.charCode === 44 || event.charCode === 46) {
      return true;
    }
    if (event.charCode > 31 && (event.charCode < 48 || event.charCode > 57)) {
      this._toastr.warning('Can\'t Input Number', 'Not Allowed');
      return false;
    } else {
      if (event.path[0].id === 'gpa' || event.path[0].id === 'yearOfExperience') {
        let maxlength = 4;
        if (event.target.value.length >= maxlength) {
          this._toastr.warning('Can\'t Input More Than 4 Digit', 'Not Allowed',
            {
              timeOut: 4000
            });
          return false;
        }
        return true;
      }
    }
    return true;
  }

  @HostListener('paste', ['$event'])
  onPaste(event: any) {
    const value = event.clipboardData.getData('Text');
    const regex = new RegExp('^[0-9.]{1,20}$');
    if (!regex.test(value)) {
      this._toastr.warning('Can\'t Paste Text', 'Not Allowed',
        {
          timeOut: 4000
        });
      return false;
    }
    return true;
  }
}

@Directive({
  selector: '[textUtils]'
})
export class TextOnlyDirective {
  constructor(private _toastr: ToastrService) {
  }

  @HostListener('keypress', ['$event'])
  onKeypress(event: any) {
    if (event.charCode > 46 && event.charCode < 65) {
      this._toastr.warning('Can\'t Input Number', 'Not Allowed',
        {
          timeOut: 4000
        });
      return false;
    } else {
      if (event.path[0].id === 'titleBeforeName') {
        let maxlength = 4;
        if (event.target.value.length >= maxlength) {
          this._toastr.warning('Can\'t Input More Than 4 Letter', 'Not Allowed',
            {
              timeOut: 4000
            });
          return false;
        }
        return true;
      }
      if (event.path[0].id === 'fullName' || event.path[0].id === 'name' || event.path[0].id === 'faculty') {
        let maxlength = 50;
        if (event.target.value.length >= maxlength) {
          this._toastr.warning('Can\'t Input More Than 50 Letter', 'Not Allowed',
            {
              timeOut: 4000
            });
          return false;
        }
        return true;
      }
      if (event.path[0].id === 'nickName') {
        let maxlength = 10;
        if (event.target.value.length >= maxlength) {
          this._toastr.warning('Can\'t Input More Than 10 Letter', 'Not Allowed',
            {
              timeOut: 4000
            });
          return false;
        }
        return true;
      }
      if (event.path[0].id === 'titleAfterName' || event.path[0].id === 'placeOfBirth') {
        let maxlength = 20;
        if (event.target.value.length >= maxlength) {
          this._toastr.warning('Can\'t Input More Than 20 Letter', 'Not Allowed',
            {
              timeOut: 4000
            });
          return false;
        }
        return true;
      }
    }
    return true;
  }

  @HostListener('paste', ['$event'])
  onPaste(event: any) {
    console.log(event);
    const value = event.clipboardData.getData('Text');
    const regex = new RegExp('^[a-zA-Z.,\' ]{3,50}$');
    if (!regex.test(value)) {
      this._toastr.warning('Can\'t Paste Number', 'Not Allowed',
        {
          timeOut: 4000
        });
      return false;
    }
    return true;
  };
}

@Directive({
  selector: '[allCharUtils]'
})
export class AllCharDirective {
  constructor(private _toastr: ToastrService) {
  }

  @HostListener('keypress', ['$event'])
  onKeypress(event: any) {
    if (event.path[0].id === 'workEmail' || event.path[0].id === 'otherEmail' ||
      event.path[0].id === 'company' || event.path[0].id === 'jobTitle' ||
      event.path[0].id === 'educationName' || event.path[0].id === 'jobTitle') {
      let maxlength = 50;
      if (event.target.value.length >= maxlength) {
        this._toastr.warning('Can\'t Input More Than 50 Letter', 'Not Allowed',
          {
            timeOut: 4000
          });
        return false;
      }
      return true;
    }
    if (event.path[0].id === 'duration') {
      let maxlength = 20;
      if (event.target.value.length >= maxlength) {
        this._toastr.warning('Can\'t Input More Than 20 Letter', 'Not Allowed',
          {
            timeOut: 4000
          });
        return false;
      }
      return true;
    }
    if (event.path[0].id === 'addressStreet' || event.path[0].id === 'addressStreetOptional' ||
      event.path[0].id === 'description' || event.path[0].id === 'skillsOther' ||
      event.path[0].id === 'comment' || event.path[0].id === 'certificateName') {
      let maxlength = 200;
      if (event.target.value.length >= maxlength) {
        this._toastr.warning('Can\'t Input More Than 200 Letter', 'Not Allowed',
          {
            timeOut: 4000
          });
        return false;
      }
      return true;
    }
    return true;
  }
}
