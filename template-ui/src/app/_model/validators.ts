import {AbstractControl} from '@angular/forms';

export function numberValidator(control: AbstractControl) {
  const regex = new RegExp('^[0-9 ]{1,20}$');
  if (control && (control.value !== null || control.value !== undefined)) {
    if (!regex.test(control.value)) {
      return {
        isError: true
      };
    }
  }
  return null;
}

export function phoneValidator(control: AbstractControl) {
  const regex = new RegExp('^[0-9 +]{9,13}$');
  if (control && (control.value !== null || control.value !== undefined)) {
    if (!regex.test(control.value)) {
      return {
        isError: true
      };
    }
  }
  return null;
}

export function ipkValidator(control: AbstractControl) {
  const regex = new RegExp('^[0-9.]{1,4}$');
  if (control && (control.value !== null || control.value !== undefined)) {
    if (!regex.test(control.value)) {
      return {
        isError: true
      };
    }
  }
  return null;
}

export function yearValidator(control: AbstractControl) {
  const regex = new RegExp('^[0-9]{4}$');
  if (control && (control.value !== null || control.value !== undefined)) {
    if (!regex.test(control.value)) {
      return {
        isError: true
      };
    }
  }
  return null;
}

export function addressValidator(control: AbstractControl) {
  const regex = new RegExp('^[a-zA-Z0-9.,\'& ]{5,100}$');
  if (control && (control.value !== null || control.value !== undefined)) {
    if (!regex.test(control.value)) {
      return {
        isError: true
      };
    }
  }
  return null;
}

export function nameValidator(control: AbstractControl) {
  const regex = new RegExp('^[a-zA-Z.,\' ]{3,50}$');
  if (control && (control.value !== null || control.value !== undefined)) {
    if (!regex.test(control.value)) {
      return {
        isError: true
      };
    }
  }
  return null;
}

export function educationValidator(control: AbstractControl) {
  const regex = new RegExp('^[a-zA-Z, - ]{2,10}$');
  if (control && (control.value !== null || control.value !== undefined)) {
    if (!regex.test(control.value)) {
      return {
        isError: true
      };
    }
  }
  return null;
}

export function descriptionValidator(control: AbstractControl) {
  const regex = new RegExp('^[a-zA-Z0-9,& ]{2,500}$');
  if (control && (control.value !== null || control.value !== undefined)) {
    if (!regex.test(control.value)) {
      return {
        isError: true
      };
    }
  }
  return null;
}

export function placeValidator(control: AbstractControl) {
  const regex = new RegExp('^[a-zA-Z.,\'& ]{3,20}$');
  if (control && (control.value !== null || control.value !== undefined)) {
    if (!regex.test(control.value)) {
      return {
        isError: true
      };
    }
  }
  return null;
}

export function letterNumberValidator(control: AbstractControl) {
  const regex = new RegExp('^[a-zA-Z0-9.-@,/*\]{3,20}$');
  if (control && (control.value !== null || control.value !== undefined)) {
    if (!regex.test(control.value)) {
      return {
        isError: true
      };
    }
  }
  return null;
}

export function otherValidator(control: AbstractControl) {
  const regex = new RegExp('^[a-zA-Z0-9.,\'& ]{3,50}$');
  if (control && (control.value !== null || control.value !== undefined)) {
    if (!regex.test(control.value)) {
      return {
        isError: true
      };
    }
  }
  return null;
}

