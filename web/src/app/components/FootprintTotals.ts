import { Injectable } from "@angular/core";
import { BehaviorSubject } from "rxjs";

@Injectable({providedIn:'root'})
export class FootprintTotals {

  private footprintValues = new BehaviorSubject('0|0|0');
  
  currentFootprintValues = this.footprintValues.asObservable();

  constructor() { }

  changeFootprintValues(value: string) {
    this.footprintValues.next(value);
  }

}