<template>
  <b-container class="bv-example-row mt-3 text-center">
    <b-container class="button-group">
      <b-button pill variant="primary" @click="displayMarker(houses)">위치 검색</b-button>
      <b-button pill variant="success" @click="searchFacilities()">편의시설 검색</b-button>
    </b-container>

    <!----------------------- 편의시설 검색 ---------------------------->
    <div class="map_wrap">
      <div id="map" style="width: 100%; height: 100%"></div>
      <ul id="category">
        <li id="BK9" data-order="0">
          <span class="category_bg bank"></span>
          은행
        </li>
        <li id="MT1" data-order="1">
          <span class="category_bg mart"></span>
          마트
        </li>
        <li id="PM9" data-order="2">
          <span class="category_bg pharmacy"></span>
          약국
        </li>
        <li id="OL7" data-order="3">
          <span class="category_bg oil"></span>
          주유소
        </li>
        <li id="CE7" data-order="4">
          <span class="category_bg cafe"></span>
          카페
        </li>
        <li id="CS2" data-order="5">
          <span class="category_bg store"></span>
          편의점
        </li>
        <li id="SW8" data-order="5">
          <span class="category_bg store"></span>
          지하철역
        </li>
      </ul>
    </div>
    <b-row>
      <b-col v-if="facilities.length">
        <div style="width: 100%; height: 500px; overflow: auto">
          <b-table-simple striped hover responsive>
            <!-- <colgroup>
            <col width="10%" />
            <col width="20%" />
            <col width="30%" />
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
          </colgroup> -->
            <b-thead head-variant="dark">
              <b-tr>
                <b-th>번호</b-th>
                <b-th>이름</b-th>
                <b-th>주소</b-th>
                <b-th>전화번호</b-th>
              </b-tr>
            </b-thead>
            <tbody>
              <!-- 하위 component인 ListRow에 데이터 전달(props) -->
              <b-tr v-for="(facility, index) in facilities" :key="index">
                <b-td class="content">{{ index + 1 }}</b-td>
                <b-td class="content">{{ facility.place }}</b-td>
                <b-td class="content">{{ facility.address }}</b-td>
                <b-td class="content">{{ facility.phone }}</b-td>
              </b-tr>
            </tbody>
          </b-table-simple>
        </div>
      </b-col>
      <b-col v-else class="text-center">시설 목록이 없습니다.</b-col>
    </b-row>
    <!-------------- ---------------------------------------->
  </b-container>
</template>

<script>
import { mapState } from "vuex";
import Image from "@/assets/home1.jpg";

const houseStore = "houseStore";
export default {
  name: "KakaoMap",
  // 집 정보를 받아온다
  computed: {
    ...mapState(houseStore, [
      "houses",
      "house",
      "flag",
      "sidos",
      "guguns",
      "sidoCode",
      "gugunCode",
    ]),
  },

  data() {
    return {
      map: null,
      aptDBMarkers: [], // DB 저장된 아파트 마커
      markers: [], // 편의시설 마커
      aptMarkers: [], // 공공api 마커
      infowindow: null,
      aptDBMarker: null, // DB 저장된 아파트 마커
      marker: null, // 편의시설 마커
      aptMarker: null, // 공공api 마커

      facilities: [],
      customOverlay: null,
    };
  },

  mounted() {
    if (window.kakao && window.kakao.maps) {
      this.initMap();
    } else {
      const script = document.createElement("script");
      /* global kakao */
      script.onload = () => kakao.maps.load(this.initMap);
      script.src =
        "//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=0661d5cb63dfe8f8d72c1705f1251ae4&libraries=services";
      document.head.appendChild(script);
    }
  },
  methods: {
    // 지도 초기화
    initMap() {
      const container = document.getElementById("map");
      const options = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 5,
      };
      this.map = new kakao.maps.Map(container, options);
      this.map.setDraggable(true);
    },
    // 마커 찍기
    displayMarker(markerPositions) {
      if (markerPositions.length == 0) {
        // this.markers.forEach((marker) => marker.setMap(null));
        alert("주택 정보를 검색하세요!");
        return;
        // this.$router.push({ name: "House" });
      }
      this.removeAptDBMarker(); // 기존 마커 제거
      this.removeAptAPIMarker(); // 기존 아파트 마커 제거

      // let positions = {};  // 하나의 아파트 위도, 경도
      let positions = [];
      let addresses = [];
      const _this = this;

      // console.log(markerPositions);

      // this.flag==1 이면 db에서 받아온 데이터, 2이면 공공데이터에서 받아온 데이터
      if (this.flag === 1) {
        const bounds = new kakao.maps.LatLngBounds();

        for (let i = 0; i < markerPositions.length; ++i) {
          let placePosition = new kakao.maps.LatLng(markerPositions[i].lat, markerPositions[i].lng);
          let aptDongMarker = this.addAptMarker(placePosition, i);
          let itemEl = this.getListItem(i, markerPositions[i]); // 검색 결과 항목 Element를 생성합니다
          bounds.extend(placePosition);

          (function (marker, title, code, place) {
            kakao.maps.event.addListener(marker, "click", function () {
              _this.displayInfowindow(marker, title, place);
              console.log(title + " " + code);
            });
            // 지도 사라지는 것
            kakao.maps.event.addListener(_this.map, "click", function () {
              console.log(_this.customOverlay);
              _this.customOverlay.setMap(null);
            });

            itemEl.onmouseover = function () {
              _this.displayInfowindow(marker, title);
            };

            itemEl.onmouseout = function () {
              _this.customOverlay.setMap(null);
            };
          })(
            aptDongMarker,
            markerPositions[i].aptName,
            markerPositions[i].aptCode,
            markerPositions[i]
          );
        }
        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        this.map.setBounds(bounds);
      } else {
        // 시도 이름+구군이름+동이름+지번으로 주소 완성
        for (let i = 0; i < markerPositions.length; ++i) {
          const sidoName = this.sidos.find((sido) => sido.value === this.sidoCode);
          const gugunName = this.guguns.find((gugun) => gugun.value === this.gugunCode);
          // console.log(sidoName.text);
          // console.log(gugunName.text);
          const addr =
            sidoName.text +
            " " +
            gugunName.text +
            " " +
            markerPositions[i].법정동 +
            " " +
            markerPositions[i].지번;
          addresses.push(addr);
        }
      }

      // const positions = markerPositions.map((position) => new kakao.maps.LatLng(...position));
      console.log(positions);
      console.log(addresses);
      for (let i = 0; i < addresses.length; ++i) {
        const geocoder = new kakao.maps.services.Geocoder();
        geocoder.addressSearch(addresses[i], function (result, status) {
          if (status === kakao.maps.services.Status.OK) {
            const coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            console.log(coords);
            _this.aptMarker = new kakao.maps.Marker({
              map: _this.map,
              position: coords,
            });
            positions.push(coords);
            _this.map.setCenter(coords);
          }
        });
      }

      if (positions.length > 0) {
        this.aptMarkers = positions.map((position) => {
          const clickMarker = new kakao.maps.Marker({
            map: this.map,
            position: position,
            clickable: true, // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
          });

          // 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
          var iwContent = '<div style="padding:5px;">Hello World!</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
            iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

          // 인포윈도우를 생성합니다
          var infowindow = new kakao.maps.InfoWindow({
            content: iwContent,
            removable: iwRemoveable,
          });

          //마커 클릭 이벤트를 등록합니다.
          kakao.maps.event.addListener(clickMarker, "click", () => {
            // 마커 위에 인포윈도우를 표시합니다
            infowindow.open(this.map, clickMarker);
          });
        });
        const bounds = positions.reduce(
          (bounds, latlng) => bounds.extend(latlng),
          new kakao.maps.LatLngBounds()
        );

        this.map.setBounds(bounds);
      }
    },

    // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
    addAptMarker(position, order) {
      var imageSrc =
          "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png", // 마커 이미지 url, 스프라이트 이미지를 씁니다
        // 카카오 api 활용
        imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
        imgOptions = {
          spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
          spriteOrigin: new kakao.maps.Point(0, order * 46 + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
          offset: new kakao.maps.Point(13, 37), // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
        marker = new kakao.maps.Marker({
          position: position, // 마커의 위치
          image: markerImage,
        });

      marker.setMap(this.map); // 지도 위에 마커를 표출합니다
      this.aptDBMarkers.push(marker); // 배열에 생성된 마커를 추가합니다

      return marker;
    },

    //검색결과 항목을 Element로 반환하는 함수입니다
    getListItem(index, place) {
      let el = document.createElement("li");
      let itemStr = `
		<span class="markerbg marker_${index + 1}></span>
		<div class="info"><h5>${place.aptName}</h5> <button>관심등록</button>
		<span>${place.sidoName} ${place.gugunName} ${place.dongName} ${place.jibun}</span>
	`;
      el.innerHTML = itemStr;
      el.className = "item";

      return el;
    },

    //검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
    //인포윈도우에 장소명을 표시합니다
    displayInfowindow(marker, title, place) {
      // const _this = this;
      //  <div class="close" onclick="${closeOverlay()}" title="닫기"></div>
      console.log(title);
      let content = `
		<div class="overlaybox">
			<div class="boxtitle">${title}</div>
			<div class="first"><img src=${Image} style="width:247px; height:136px;" alt=""></div>
			<ul>
				<li class="up">
					<span class="title">건축년도</span>
					<span class="count">${place.buildYear}</span>
				</li>
				<li>
					<span class="title">주소</span>
					<span class="count">${place.sidoName} ${place.gugunName} ${place.dongName} ${place.jibun}</span>
				</li>
				<li>
					<span class="title">최신거래금액</span>
					<span class="count">${place.recentPrice}</span>
				</li>
				<li>
					<span class="last" id="recenthistor" data-toggle="modal" data-target="#myModal">주택정보 update</span>
				</li>
			</ul>
		</div>
	`;
      var position = new kakao.maps.LatLng(
        marker.getPosition().getLat() + 0.00033,
        marker.getPosition().getLng() - 0.00003
      );
      this.customOverlay = new kakao.maps.CustomOverlay({
        position: position,
        content: content,
        xAnchor: 0.3,
        yAnchor: 0.91,
      });
      this.customOverlay.setMap(this.map);

      // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다
      // console.log(_this);
      // function closeOverlay() {
      //   // console.log(_this.customOverlay);
      //   _this.customOverlay.setMap(null);
      // }
    },

    /********************************************* */
    // 편의시설 검색
    searchFacilities() {
      const _this = this;

      // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
      let placeOverlay = new kakao.maps.CustomOverlay({ zIndex: 1 }),
        contentNode = document.createElement("div"), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다
        currCategory = ""; // 현재 선택된 카테고리를 가지고 있을 변수입니다

      // 장소 검색 객체를 생성합니다
      let ps = new kakao.maps.services.Places(this.map);

      // 지도에 idle 이벤트를 등록합니다
      kakao.maps.event.addListener(this.map, "idle", searchPlaces);

      // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다
      contentNode.className = "placeinfo_wrap";

      // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
      // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다
      addEventHandle(contentNode, "mousedown", kakao.maps.event.preventMap);
      addEventHandle(contentNode, "touchstart", kakao.maps.event.preventMap);

      // 커스텀 오버레이 컨텐츠를 설정합니다
      placeOverlay.setContent(contentNode);

      // 각 카테고리에 클릭 이벤트를 등록합니다
      addCategoryClickEvent();

      function addEventHandle(target, type, callback) {
        if (target.addEventListener) {
          target.addEventListener(type, callback);
        } else {
          target.attachEvent("on" + type, callback);
        }
      }

      // 카테고리 검색을 요청하는 함수입니다
      function searchPlaces() {
        if (!currCategory) {
          return;
        }

        // 커스텀 오버레이를 숨깁니다
        placeOverlay.setMap(null);

        // 지도에 표시되고 있는 마커를 제거합니다
        _this.removeMarker();
        _this.facilities = []; // 배열 비우기

        ps.categorySearch(currCategory, placesSearchCB, { useMapBounds: true });
      }

      // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
      function placesSearchCB(data, status) {
        if (status === kakao.maps.services.Status.OK) {
          // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
          displayPlaces(data);
        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
          // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요
        } else if (status === kakao.maps.services.Status.ERROR) {
          // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
        }
      }

      // 지도에 마커를 표출하는 함수입니다
      function displayPlaces(places) {
        // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
        // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
        var order = document.getElementById(currCategory).getAttribute("data-order");

        for (var i = 0; i < places.length; i++) {
          // 마커를 생성하고 지도에 표시합니다
          // console.log(places[i]);
          // 주변 시설 정보 저장
          _this.facilities.push({
            place: places[i].place_name,
            address: places[i].road_address_name,
            phone: places[i].phone,
          });
          _this.marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);

          // 마커와 검색결과 항목을 클릭 했을 때
          // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
          (function (marker, place) {
            kakao.maps.event.addListener(marker, "click", function () {
              displayPlaceInfo(place);
            });
          })(_this.marker, places[i]);
        }
        // console.log(_this.facilities);
      }

      // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
      function addMarker(position, order) {
        var imageSrc =
            "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png", // 마커 이미지 url, 스프라이트 이미지를 씁니다
          imageSize = new kakao.maps.Size(27, 28), // 마커 이미지의 크기
          imgOptions = {
            spriteSize: new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
            spriteOrigin: new kakao.maps.Point(46, order * 36), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(11, 28), // 마커 좌표에 일치시킬 이미지 내에서의 좌표
          },
          markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
          marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage,
          });

        // console.log(_this);
        marker.setMap(_this.map); // 지도 위에 마커를 표출합니다
        _this.markers.push(marker); // 배열에 생성된 마커를 추가합니다

        return marker;
      }

      // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
      function displayPlaceInfo(place) {
        var content =
          '<div class="placeinfo">' +
          '   <a class="title" href="' +
          place.place_url +
          '" target="_blank" title="' +
          place.place_name +
          '">' +
          place.place_name +
          "</a>";
        if (place.road_address_name) {
          content +=
            '    <span title="' +
            place.road_address_name +
            '">' +
            place.road_address_name +
            "</span>" +
            '  <span class="jibun" title="' +
            place.address_name +
            '">(지번 : ' +
            place.address_name +
            ")</span>";
        } else {
          content +=
            '    <span title="' + place.address_name + '">' + place.address_name + "</span>";
        }

        content +=
          '    <span class="tel">' +
          place.phone +
          "</span>" +
          "</div>" +
          '<div class="after">' +
          "</div>";

        // '<div class="close" onclick=' +
        // closeOverlay() +
        // 'title="닫기"></div> ' +

        contentNode.innerHTML = content;
        placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
        placeOverlay.setMap(_this.map);
      }

      // 각 카테고리에 클릭 이벤트를 등록합니다
      function addCategoryClickEvent() {
        var category = document.getElementById("category"),
          children = category.children;

        for (var i = 0; i < children.length; i++) {
          children[i].onclick = onClickCategory;
        }
      }

      // 카테고리를 클릭했을 때 호출되는 함수입니다
      function onClickCategory() {
        _this.facilities = []; // 배열 비우기
        var id = this.id,
          className = this.className;

        placeOverlay.setMap(null);

        if (className === "on") {
          currCategory = "";
          changeCategoryClass();
          _this.removeMarker();
        } else {
          currCategory = id;
          changeCategoryClass(this);
          searchPlaces();
        }
      }

      // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
      function changeCategoryClass(el) {
        var category = document.getElementById("category"),
          children = category.children,
          i;

        for (i = 0; i < children.length; i++) {
          children[i].className = "";
        }

        if (el) {
          el.className = "on";
        }
      }

      // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다
      // function closeOverlay() {
      //   placeOverlay.setMap(null);
      // }
    },
    /*********************************************** */
    removeAptDBMarker() {
      for (let i = 0; i < this.aptDBMarkers.length; i++) {
        this.aptDBMarkers[i].setMap(null);
      }
      this.aptDBMarkers = [];
    },

    removeAptAPIMarker() {
      for (let i = 0; i < this.aptMarkers.length; i++) {
        this.aptMarkers[i].setMap(null);
      }
      this.aptMarkers = [];
    },
    removeMarker() {
      for (let i = 0; i < this.markers.length; i++) {
        this.markers[i].setMap(null);
      }
      this.markers = [];
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>
#map {
  width: 400px;
  height: 400px;
}

.button-group {
  margin: 10px 0px;
}

button {
  margin: 0 3px;
}

/************ 편의시설 style ***** */
.map_wrap,
.map_wrap * {
  margin: 0;
  padding: 0;
  font-family: "Malgun Gothic", dotum, "돋움", sans-serif;
  font-size: 12px;
}
.map_wrap {
  position: relative;
  width: 100%;
  height: 350px;
}
#category {
  position: absolute;
  top: 10px;
  left: 10px;
  border-radius: 5px;
  border: 1px solid #909090;
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);
  background: #fff;
  overflow: hidden;
  z-index: 2;
}
#category li {
  float: left;
  list-style: none;
  width: 50px;
  border-right: 1px solid #acacac;
  padding: 6px 0;
  text-align: center;
  cursor: pointer;
}
#category li.on {
  background: #eee;
}
#category li:hover {
  background: #ffe6e6;
  border-left: 1px solid #acacac;
  margin-left: -1px;
}
#category li:last-child {
  margin-right: 0;
  border-right: 0;
}
#category li span {
  display: block;
  margin: 0 auto 3px;
  width: 27px;
  height: 28px;
}
#category li .category_bg {
  background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png)
    no-repeat;
}
#category li .bank {
  background-position: -10px 0;
}
#category li .mart {
  background-position: -10px -36px;
}
#category li .pharmacy {
  background-position: -10px -72px;
}
#category li .oil {
  background-position: -10px -108px;
}
#category li .cafe {
  background-position: -10px -144px;
}
#category li .store {
  background-position: -10px -180px;
}
#category li.on .category_bg {
  background-position-x: -46px;
}
.placeinfo_wrap {
  position: absolute;
  bottom: 28px;
  left: -150px;
  width: 300px;
}
.placeinfo {
  position: relative;
  width: 100%;
  border-radius: 6px;
  border: 1px solid #ccc;
  border-bottom: 2px solid #ddd;
  padding-bottom: 10px;
  background: #fff;
}
.placeinfo:nth-of-type(n) {
  border: 0;
  box-shadow: 0px 1px 2px #888;
}
.placeinfo_wrap .after {
  content: "";
  position: relative;
  margin-left: -12px;
  left: 50%;
  width: 22px;
  height: 12px;
  background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png);
}
.placeinfo a,
.placeinfo a:hover,
.placeinfo a:active {
  color: #fff;
  text-decoration: none;
}
.placeinfo a,
.placeinfo span {
  display: block;
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
}
.placeinfo span {
  margin: 5px 5px 0 5px;
  cursor: default;
  font-size: 13px;
}
.placeinfo .title {
  font-weight: bold;
  font-size: 14px;
  border-radius: 6px 6px 0 0;
  margin: -1px -1px 0 -1px;
  padding: 10px;
  color: #fff;
  background: #d95050;
  background: #d95050
    url("https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png") no-repeat right
    14px center;
}
.placeinfo .tel {
  color: #0f7833;
}
.placeinfo .jibun {
  color: #999;
  font-size: 11px;
  margin-top: 0;
}
.overlaybox {
  position: relative;
  width: 360px;
  height: 350px;
  background: url("https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/box_movie.png")
    no-repeat;
  padding: 15px 10px;
}
.overlaybox div,
ul {
  overflow: hidden;
  margin: 0;
  padding: 0;
}
.overlaybox li {
  list-style: none;
}
.overlaybox .boxtitle {
  color: #fff;
  font-size: 16px;
  font-weight: bold;
  background: url("https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png")
    no-repeat right 120px center;
  margin-bottom: 8px;
  text-align: left;
}
.overlaybox .first {
  position: relative;
  width: 247px;
  height: 136px;
  margin-bottom: 8px;
}
.first .text {
  color: #fff;
  font-weight: bold;
}
.first .triangle {
  position: absolute;
  width: 48px;
  height: 48px;
  top: 0;
  left: 0;
  background: url("https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/triangle.png") no-repeat;
  padding: 6px;
  font-size: 18px;
}
.first .movietitle {
  position: absolute;
  width: 100%;
  bottom: 0;
  background: rgba(0, 0, 0, 0.4);
  padding: 7px 15px;
  font-size: 14px;
}
.overlaybox ul {
  width: 247px;
}
.overlaybox li {
  position: relative;
  margin-bottom: 2px;
  background: #2b2d36;
  padding: 5px 10px;
  color: #aaabaf;
  line-height: 1;
  text-align: left;
}
.overlaybox li span {
  display: inline-block;
}
.overlaybox li .number {
  font-size: 16px;
  font-weight: bold;
}
.overlaybox li .title {
  font-size: 13px;
}
.overlaybox li .last {
  font-size: 12px;
  margin-right: 15px;
}
.overlaybox ul .arrow {
  position: absolute;
  margin-top: 8px;
  right: 25px;
  width: 5px;
  height: 3px;
  background: url("https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/updown.png") no-repeat;
}
.overlaybox li .up {
  background-position: 0 -40px;
}
.overlaybox li .down {
  background-position: 0 -60px;
}
.overlaybox li .count {
  position: absolute;
  margin-top: 5px;
  right: 15px;
  font-size: 10px;
}
.overlaybox li:hover {
  color: #fff;
  background: #d24545;
}
.overlaybox li:hover .up {
  background-position: 0 0px;
  text-align: left;
}
.overlaybox li:hover .down {
  background-position: 0 -20px;
}
.row {
  margin-top: 10px;
  margin-bottom: 30px;
}
</style>
