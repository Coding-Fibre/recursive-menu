<template>
  <div class="menu-item" :class="{ expanded: expanded }">
    <div 
      class="label"
      @click="toggleMenu()"
      :style="{
        paddingLeft: depth * 20 + 20 + 'px'
      }"
    >
      <div class="left">
        <i v-if="icon" class="material-icons">{{ icon }}</i>
        <span>{{ label }}</span>
      </div>
      <div v-if="data" class="right">
        <i class="material-icons expand" :class="{ expanded: expanded }">expand_more</i>
      </div>
    </div>
    <div 
      v-show="showChildren"
      class="items-container"
      ref="container"
      :style="{ height: containerHeight }"
    >
      <menu-item
        v-for="(item, index) in data"
        :key="index"
        :label="item.label"
        :icon="item.icon"
        :depth="depth + 1"
        :data="item.children"
      />
    </div>
  </div>
</template>

<script>
export default {
  name: "menu-item",
  data: () => ({
    showChildren: false,
    expanded: false,
    containerHeight: 0
  }),
  props: {
    label: {
      type: String,
      required: true
    },
    icon: {
      type: String
    },
    depth: {
      type: Number,
      required: true
    },
    data: {
      type: Array
    }
  },
  methods: {
    toggleMenu() {
      this.expanded = !this.expanded;
      // If the menu item is closed
      if(!this.showChildren) {
        this.showChildren = true;
        this.$nextTick(() => {
          // We get the height of what's inside the container to start the animation
          this.containerHeight = this.$refs["container"].scrollHeight + "px";
          setTimeout(() => {
            this.containerHeight = "fit-content";
            // We set the overflow of the container to visible at the end of the
            // animation
            this.$refs["container"].style.overflow = "visible";
          }, 300) // Duration of the animation
        })
      } else {
        this.containerHeight = this.$refs["container"].scrollHeight + "px";
        // We set the overflow of the container to hidden to avoid text overlapping
        // during the animation
        this.$refs["container"].style.overflow = "hidden";
        // This trick allows us to play the animation when the CSS is all well set
        setTimeout(() => {
          this.containerHeight = 0 + "px";
        }, 10)
        setTimeout(() => {
          this.showChildren = false;
        }, 300) // Duration of the animation
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.menu-item {
  position: relative;
  width: 100%;
  .label {
    width: 100%;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    white-space: nowrap;
    user-select: none;
    height: 50px;
    padding: 0 20px;
    box-sizing: border-box;
    color: #6a6a6a;
    transition: all .3s ease;
    > div {
      display: flex;
      align-items: center;
      gap: 10px;
    }
    i {
      font-size: 20px;
      color: #6e6e6e;
      transition: all .3s ease;
      &.expand {
        font-size: 16px;
        color: #cacaca;
        &.expanded {
          transform: rotate(180deg);
        }
      }
    }
    &:hover {
      background-color: #deedff;
      cursor: pointer;
    }
  }
  .items-container {
    width: 100%;
    overflow: hidden;
    transition: height .3s ease;
  }
}
</style>