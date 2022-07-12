import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { take } from 'rxjs/operators';
import { Stationary } from './stationary';

@Injectable({
  providedIn: 'root'
})
export class StationaryService {

  private url = environment.host + 'stationary';

  constructor(private http: HttpClient) { }

  public list(): Observable<Stationary[]> {
    return this.http.get<Stationary[]>(this.url).pipe(take(1));
  }

  public get(stationaryCombustionId: number): Observable<Stationary> {
    return this.http.get<Stationary>(`${this.url}/${stationaryCombustionId}`).pipe(take(1));
  }

  public delete(stationaryCombustionId: number): Observable<any> {
    return this.http.delete<any>(`${this.url}/${stationaryCombustionId}`).pipe(take(1));
  }

  public save(stationary: Stationary): Observable<Stationary> {
    return this.http.post<Stationary>(`${this.url}`, stationary).pipe(take(1));
  }

}
