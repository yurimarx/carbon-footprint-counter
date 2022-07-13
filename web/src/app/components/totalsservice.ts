import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { take } from 'rxjs/operators';
import { Totals } from './totals';

@Injectable({
  providedIn: 'root'
})
export class TotalsService {

  private url = environment.host + 'totals';

  constructor(private http: HttpClient) { }

  public getTotals(): Observable<Totals> {
    return this.http.get<Totals>(this.url).pipe(take(1));
  }

 }
