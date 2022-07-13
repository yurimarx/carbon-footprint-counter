import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { take } from 'rxjs/operators';
import { Transportation } from './transportation';

@Injectable({
  providedIn: 'root'
})
export class TransportationService {

  private url = environment.host + 'transportation';

  constructor(private http: HttpClient) { }

  public list(): Observable<Transportation[]> {
    return this.http.get<Transportation[]>(this.url).pipe(take(1));
  }

  public get(transportationId: number): Observable<Transportation> {
    return this.http.get<Transportation>(`${this.url}/${transportationId}`).pipe(take(1));
  }

  public calculate(id: number, amount: number): Observable<Transportation> {
    return this.http.get<Transportation>(`${this.url}/calculate/${id}/${amount}`).pipe(take(1));
  }

  public delete(transportationId: number): Observable<any> {
    return this.http.delete<any>(`${this.url}/${transportationId}`).pipe(take(1));
  }

  public save(transportation: Transportation): Observable<Transportation> {
    return this.http.post<Transportation>(`${this.url}`, transportation).pipe(take(1));
  }

}
