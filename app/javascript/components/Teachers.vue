<template>

    <div class="container-profile w80">
      <h6>Buscar</h6>
      <input type="text" name="" v-model="search" placeholder="Buscar usuario">
      <div v-for="user in filteredUsers" >

          <figure class="snip1344">
            <img :src="user.url" alt="profile-sample1" class="background"/>
            <img :src="user.url" alt="profile-sample1" class="profile"/>
            <figcaption>
              <h6>{{user.name | truncate('20')}}<span>{{user.position}}</span></h6>
              <div class="icons" ><a v-on:click="addTeacher(user)" class="btn">Agregar</a></div>
            </figcaption>
          </figure>
        </div>

        <div style="position:fixed;right:0;width:250px;top: 70px;" class="">
          <h5>Profesores</h5>
          <ul class="collection" style="height:70vh;overflow: scroll;" >
            <li v-for="(teacher,index) in teachers"  class="collection-item avatar">
              <img :src="teacher.url" alt="" class="circle">
              <span class="title">{{teacher.name | truncate('20')}}</span>
              <p>
                {{teacher.position}}
              </p>
              <a  v-on:click="removeTeacher(teacher,index)" class="secondary-content" style="cursor: pointer;"><i class="material-icons red-text">delete</i></a>
            </li>

          </ul>
        </div>
      </div>


</template>

<script>
export default {
  data(){
    return{
      users: null,
      search: "",
      teachers: null
    }
  },
  filters: {
  	truncate: function(string, value) {
    	return string.substring(0, value) + '...';
    }
  },
  mounted(){
    this.users = JSON.parse(gon.users)
    this.teachers = JSON.parse(gon.teachers)
  },
  computed:
  {
      filteredUsers:function()
      {
          if(this.users ==null)
          {
            return []

          }
          else
          {

            var self=this;
            var u = this.users.filter(function(user){
                                        return user.name.toLowerCase().indexOf(self.search.toLowerCase())>=0;
                                      });
            if(u == null)
              return []
            else
              return u
          }
      }
  },
  methods:{
    removeTeacher: function (teacher,index){
      this.$http.get(`/admin/courses/${gon.course_id}/teachers/remove?user_id=${teacher.id}`)
      .then(response => {
        this.users.push(teacher)
        this.teachers.splice(index,1)
      }, response => {
      // error callback
      });
    },
    addTeacher: function (user){

      this.$http.get(`/admin/courses/${gon.course_id}/teachers/add?user_id=${user.id}`)
      .then(response => {
        this.teachers.push(user)
        var index = this.users.indexOf(user)
        this.users.splice(index,1)

      }, response => {
      // error callback
      });
    }
  }
}
</script>

<style  type="text/css">
  .w80{
    width: 80%;
  }
</style>
