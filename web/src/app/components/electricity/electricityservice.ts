import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { take } from 'rxjs/operators';
import { Electricity } from './electricity';

@Injectable({
  providedIn: 'root'
})
export class ElectricityService {

  private url = environment.host + 'electricity';

  constructor(private http: HttpClient) { }

  public list(): Observable<Electricity[]> {
    return this.http.get<Electricity[]>(this.url).pipe(take(1));
  }

  public get(electricityId: number): Observable<Electricity> {
    return this.http.get<Electricity>(`${this.url}/${electricityId}`).pipe(take(1));
  }

  public calculate(id: number, amount: number): Observable<Electricity> {
    return this.http.get<Electricity>(`${this.url}/calculate/${id}/${amount}`).pipe(take(1));
  }

  public delete(electricityId: number): Observable<any> {
    return this.http.delete<any>(`${this.url}/${electricityId}`).pipe(take(1));
  }

  public save(electricity: Electricity): Observable<Electricity> {
    return this.http.post<Electricity>(`${this.url}`, electricity).pipe(take(1));
  }

}
