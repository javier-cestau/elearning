<template>

    <div class="container-profile col s12">
      <input type="text" name="" v-model="search">
      <div v-for="(user,index) in filteredUsers" >

          <figure class="snip1344">
            <img :src="user.url" alt="profile-sample1" class="background"/>
            <img :src="user.url" alt="profile-sample1" class="profile"/>
            <figcaption>
              <h6>{{user.name | truncate('20')}}<span>{{user.position}}</span></h6>
              <div class="icons" ><a v-on:click="addTeacher(user,index)" class="btn">Agregar</a></div>
            </figcaption>
          </figure>
        </div>

        <div style="position:fixed;right:0;width:250px;" class="">
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
            return ["No hay nada"]

          }
          else
          {

            var self=this;
            var u = this.users.filter(function(user){return user.name.toLowerCase().indexOf(self.search.toLowerCase())>=0;});
            if(u == null){
              return ["No hay nada"]
            }
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
    addTeacher: function (user,index){

      this.$http.get(`/admin/courses/${gon.course_id}/teachers/add?user_id=${user.id}`)
      .then(response => {
        this.teachers.push(user)
        console.log(index);
        console.log(user);
        this.users.splice(index,1)
      }, response => {
      // error callback
      });
    }
  }
}
</script>

<style >
</style>
