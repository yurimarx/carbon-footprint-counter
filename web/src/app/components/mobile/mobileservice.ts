import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { take } from 'rxjs/operators';
import { Mobile } from './mobile';

@Injectable({
  providedIn: 'root'
})
export class MobileService {

  private url = environment.host + 'mobile';

  constructor(private http: HttpClient) { }

  public list(): Observable<Mobile[]> {
    return this.http.get<Mobile[]>(this.url).pipe(take(1));
  }

  public get(mobileCombustionId: number): Observable<Mobile> {
    return this.http.get<Mobile>(`${this.url}/${mobileCombustionId}`).pipe(take(1));
  }

  public calculate(id: number, amount: number): Observable<Mobile> {
    return this.http.get<Mobile>(`${this.url}/calculate/${id}/${amount}`).pipe(take(1));
  }

  public delete(mobileCombustionId: number): Observable<any> {
    return this.http.delete<any>(`${this.url}/${mobileCombustionId}`).pipe(take(1));
  }

  public save(mobile: Mobile): Observable<Mobile> {
    return this.http.post<Mobile>(`${this.url}`, mobile).pipe(take(1));
  }

}
