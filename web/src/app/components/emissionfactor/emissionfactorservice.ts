import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { take } from 'rxjs/operators';
import { EmissionFactor } from './emissionfactor';

@Injectable({
  providedIn: 'root'
})
export class EmissionFactorService {

  private url = environment.host + 'emissionfactors';

  constructor(private http: HttpClient) { }

  public list(): Observable<EmissionFactor[]> {
    return this.http.get<EmissionFactor[]>(this.url).pipe(take(1));
  }

  public get(emissionFactorId: number): Observable<EmissionFactor> {
    return this.http.get<EmissionFactor>(`${this.url}/${emissionFactorId}`).pipe(take(1));
  }

  public delete(emissionFactorId: number): Observable<any> {
    return this.http.delete<any>(`${this.url}/${emissionFactorId}`).pipe(take(1));
  }

  public save(emissionFactor: EmissionFactor): Observable<EmissionFactor> {
    return this.http.post<EmissionFactor>(`${this.url}`, emissionFactor).pipe(take(1));
  }

}
