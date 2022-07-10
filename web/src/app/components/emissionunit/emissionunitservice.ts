import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { take } from 'rxjs/operators';
import { EmissionUnit } from './emissionunit';

@Injectable({
  providedIn: 'root'
})
export class EmissionUnitService {

  private url = environment.host + 'emissionunits';

  constructor(private http: HttpClient) { }

  public list(): Observable<EmissionUnit[]> {
    return this.http.get<EmissionUnit[]>(this.url).pipe(take(1));
  }

  public get(emissionUnitId: number): Observable<EmissionUnit> {
    return this.http.get<EmissionUnit>(`${this.url}/${emissionUnitId}`).pipe(take(1));
  }

  public delete(emissionUnitId: number): Observable<any> {
    return this.http.delete<any>(`${this.url}/${emissionUnitId}`).pipe(take(1));
  }

  public save(emissionUnit: EmissionUnit): Observable<EmissionUnit> {
    return this.http.post<EmissionUnit>(`${this.url}`, emissionUnit).pipe(take(1));
  }

}
