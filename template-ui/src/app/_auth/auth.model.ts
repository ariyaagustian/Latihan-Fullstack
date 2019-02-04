export interface Authentication {
  username: string;
  password: string;
}

export class Token {

  constructor(public access_token: string, public token_type?: string, public refresh_token?: string, public expires_in?: string, public scope?: string[]) {
  }
}


export class User {
  constructor(public user?: string, public access?: Date) {
  }
}

export class CurrentUser {

  public aud: string[];
  public user_name: string;
  public scope: string[];
  public exp: Date;
  public authorities: string[];
  public client_id: string;
  public access_token: string;
  public expired: boolean;
  public user: UserCurrent;
  // public mappingUrl: MappingUrl[];
  public listDivision: ListDivision[];
}

export class UserCurrent {
  public id: string;
  public email: string;
  public password: string;
  public name: string;
  public enabled: boolean;
  public createdDate: Date;
  public createdBy: string;
  public lastUpdatedDate: Date;
  public lastUpdatedBy: string;
  public listDivision: Division[];
  public listRoles: Roles[];
  public listUrls: ListUrl[];
  public defaultPage: string;
  public loginId: string;
  public listRoleId: number[];
}

export class MappingUrl {
  public id: number;
  public user: User;
  public listUrl: ListUrl;
}

export class RoleIds {
  roleIds: number[];
}

export class Roles {
  public id: number;
  public name: string;
}

export class Division {
  public id: number;
  public name: string;
}

export class ListDivision {
  public divisi: Division;
  public listUrl: ListUrl;
}

export class ListUrl {
  public id: number;
  public url: string;
  public name: string;
  public icon: string;
  public children: ListUrl[];
}

export class ListUrlChildren {
  public id: number;
  public url: string;
  public name: string;
  public icon: string;
}
