<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>쇼핑몰</title>

    <style>
        
        @keyframes blink-effect {
            50%{
                opacity: 0;

            }
        }
		
		.table.table-border > thead > tr > th{
           height:55px !important;
        }
        .table.table-border > tbody > tr > td{
           height:55px !important;
        }
        
    </style>

<!--     score jquery plugin -->
<!--     <script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.js"></script> -->
<!--     <script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.min.js"></script> -->

<!--     jquery cdn -->
<!--     <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> -->
<!--      <script src="checkbox.js"></script> -->
<!--      <script src="confirm-link.js"></script> -->
<!--      <script src="multipage.js"></script> -->
<!--      <script src="chart.js"></script> -->

    
    <!-- 자바스크립트 코드 작성 영역 -->
    <script type="text/javascript">

    </script>
</head>
<body>
    <div class="container w-1000 my-50">
        <div class="row center">
            <h4><i class="fa-solid fa-tape"></i>MY&nbsp;&nbsp;<b style="font-weight: bold;">FIT</b>&nbsp;&nbsp;SIZE</h4>
        </div>
        <div class="row flex-box column-2">
            <div class="left">
                <img src='https://ifh.cc/g/7jYYwV.png' style="max-width: 100%; height: auto;">
            </div>

            <div class="right">
                <img src='https://ifh.cc/g/VL2f7w.png' style="max-width: 100%; height: auto;">
            </div>    
        </div>
        <div class="row flex-box column-2">
            <div class="left">
                <div class="row center">
                    <i class="fa-solid fa-shirt" style="animation: blink-effect 2s ease-in-out infinite;"></i>SHIRTS
                </div>

                <table class="table table-border">
                    <thead style="height: 50px; background-color: #f8fbfd;">
                        <tr>
                            <th style="font-weight: bold;">사이즈</th>
                            <th style="font-weight: bold;">어깨</th>
                            <th style="font-weight: bold;">가슴</th>
                            <th style="font-weight: bold;">소매</th>
                            <th style="font-weight: bold;">총기장</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td style="font-weight: bold; background-color: #f8fbfd;">S</td>
                            <td>46</td>
                            <td>49</td>
                            <td>56</td>
                            <td>65</td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold; background-color: #f8fbfd;">M</td>
                            <td>48</td>
                            <td>51</td>
                            <td>57</td>
                            <td>67</td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold; background-color: #f8fbfd;">L</td>
                            <td>50</td>
                            <td>53</td>
                            <td>58</td>
                            <td>69</td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold; background-color: #f8fbfd;">XL</td>
                            <td>52</td>
                            <td>55</td>
                            <td>59</td>
                            <td>71</td>
                        </tr>
                    </tbody>
                </table>
                <span style="font-size: 14px; color: #949596;">단위:<b style="font-size: 12px; color: #949596;">cm</b></span>
            </div>

            <div class="right">
                <div class="row center">
                    <i class="fa-solid fa-shirt" style="animation: blink-effect 2s ease-in-out infinite;"></i>PANTS
                </div>
                <table class="table table-border">
                    <thead style="height: 50px; background-color: #f8fbfd;">
                        <tr>
                            <th style="font-weight: bold;">사이즈</th>
                            <th style="font-weight: bold;">허리</th>
                            <th style="font-weight: bold;">허벅지</th>
                            <th style="font-weight: bold;">밑위</th>
                            <th style="font-weight: bold;">밑단</th>
                            <th style="font-weight: bold;">총기장</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td style="font-weight: bold; background-color: #f8fbfd;">S</td>
                            <td>33</td>
                            <td>29</td>
                            <td>31</td>
                            <td>17</td>
                            <td>
                            90 / 숏<br>
                            95 / 일반
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold; background-color: #f8fbfd;">M</td>
                            <td>36</td>
                            <td>30</td>
                            <td>32</td>
                            <td>18</td>
                            <td>
                             91 / 숏<br>
                             96 / 일반
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold; background-color: #f8fbfd;">L</td>
                            <td>50</td>
                            <td>53</td>
                            <td>58</td>
                            <td>69</td>
                            <td>
                            93 / 숏<br>
                            98 / 일반
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold; background-color: #f8fbfd;">XL</td>
                            <td>52</td>
                            <td>55</td>
                            <td>59</td>
                            <td>71</td>
                            <td>
                            95 / 숏<br>
                            100 / 일반
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            </div>
            <div class="left" style="font-size: 12px;">
                <span style="color: #949596;">- 사이즈는 측정방법에 따라 1~3cm 정도 오차가 있을 수 있습니다.</span><br>
                <span style="color: #949596;">- 제품색상은 사용자의 모니터의 해상도에 따라 실제 색상과 다소 차이가 있을 수 있습니다.</span><br>
                <span style="color: #949596;">- 제품의 색상은 하단 디테일컷 색상과 가장 흡사하니 <b style="font-weight: bolder; color: black;">DETAIL VIEW</b>를 확인하시고 구매해주세요.</span><br><br>

                <span style="color: #949596;">※ 사이즈택은 사이즈와 관계없이 임의의 사이즈택으로 부착되어 발송될 수 있습니다.</span>
            </div>
        </div>
    </div>
</body>
</html>